# 헬릭스 리눅스 p4 클라이언트 설치 (Helix Linux p4 Client Installation)

Perforce Helix 클라이언트 `p4` 바이너리만 받아서 `~/.local/bin`에 설치한다.

## 다운로드 위치

Perforce FTP:

<https://ftp.perforce.com/perforce/>

2026년 기준으로 `p4`는 `r25.1` 아래에 있다.

예시 경로:

```bash
https://ftp.perforce.com/perforce/r25.1/bin.linux26aarch64/p4
```

## 설치

```bash
mkdir -p ~/.local/bin
curl -L -o ~/.local/bin/p4 https://ftp.perforce.com/perforce/r25.1/bin.linux26aarch64/p4
chmod 755 ~/.local/bin/p4
```

## 확인

```bash
p4 -V
```

정상 설치되면 Perforce 버전 정보가 출력된다.

예:

```text
Rev. P4/LINUX26AARCH64/2025.1/2907437
```

## 참고

* 환경에 따라 아키텍처에 맞는 폴더를 선택해야 한다.
  * 예: `bin.linux26aarch64`
  * 예: `bin.linux26x86_64`
* `~/.local/bin`이 `PATH`에 들어 있어야 `p4`를 바로 실행할 수 있다.
