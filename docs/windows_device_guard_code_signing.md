# Windows Device Guard & Code Signing

## 상황

사내 PyInstaller 빌드 실행 파일(`.exe`)을 배포했을 때 일부 PC에서 실행이 차단됨.

```
'C:\...\app.exe' 조직의 Device Guard 정책에 의해 차단되었습니다.
자세한 내용은 지원 담당자에게 문의하세요.
```

기존에 배포되어 있던 실행 파일은 정상 실행되고, 새로 추가한 파일만 차단됨.

---

## 분석

### Device Guard (WDAC) 동작 방식

Windows Defender Application Control(WDAC)은 실행 파일의 **해시 또는 서명**을 기준으로 허용 여부를 결정한다.

- 정책 생성 시점에 존재하던 실행 파일 → 해시가 허용 목록에 등록됨
- 이후 새로 생성/추가된 실행 파일 → 목록에 없으므로 차단됨

### 기존 exe가 동작했던 이유

WDAC 정책이 처음 구성될 때 기존 실행 파일의 해시가 자동 수집되어 등록됨.
이후 파일명이 달라지거나 새로 추가된 파일은 미등록 상태이므로 차단.

### Smart App Control과의 차이

| 항목 | Smart App Control | Device Guard (WDAC) |
|---|---|---|
| 관리 주체 | Windows 자체 (Microsoft 클라우드 평판) | 조직 정책 |
| 폴더 예외 | 불가 | 경로 규칙으로 가능 |
| 해제 방법 | 전역 끄기 (복구 불가) | 정책 수정 |

---

## 대응

### 근본 해결: 코드 서명

자체 서명 인증서로 실행 파일에 서명하면 WDAC/Smart App Control 모두 통과.
팀원 PC에 인증서를 한 번만 등록하면 이후 빌드는 자동 허용.

#### 1. 인증서 생성 (빌드 담당자 PC, 1회)

```powershell
$cert = New-SelfSignedCertificate `
    -Type CodeSigningCert `
    -Subject "CN=My Internal Tools" `
    -CertStoreLocation "Cert:\CurrentUser\My" `
    -NotAfter (Get-Date).AddYears(10) `
    -KeyUsage DigitalSignature `
    -KeyAlgorithm RSA `
    -KeyLength 4096

# 서명용 (비공개)
Export-PfxCertificate -Cert $cert -FilePath "internal-cert.pfx" -Password (Read-Host -AsSecureString "PFX Password")

# 배포용 (팀 공유)
Export-Certificate -Cert $cert -FilePath "internal-cert.cer" -Type CERT
```

#### 2. 인증서 등록 (실행할 PC마다, 1회, 관리자 권한)

```powershell
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2("internal-cert.cer")

# Trusted Publishers — 서명된 exe 실행 허용
$tp = New-Object System.Security.Cryptography.X509Certificates.X509Store("TrustedPublisher", "LocalMachine")
$tp.Open("ReadWrite"); $tp.Add($cert); $tp.Close()

# Root CA — 인증서 체인 검증
$ca = New-Object System.Security.Cryptography.X509Certificates.X509Store("Root", "LocalMachine")
$ca.Open("ReadWrite"); $ca.Add($cert); $ca.Close()
```

#### 3. 실행 파일 서명

`signtool.exe`는 **Windows SDK Signing Tools for Desktop Apps** 설치 후 사용 가능.

```bat
set SIGNTOOL="C:\Program Files (x86)\Windows Kits\10\bin\10.0.28000.0\x64\signtool.exe"

%SIGNTOOL% sign /f internal-cert.pfx /p <password> /fd SHA256 /t http://timestamp.digicert.com app.exe
```

---

## 주의사항

- `.pfx`(개인 키 포함)는 절대 공개 저장소에 올리지 않는다
- `.cer`(공개 키)만 팀 공유
- 비밀번호는 환경 변수로 관리 — 스크립트에 평문 기재 금지
