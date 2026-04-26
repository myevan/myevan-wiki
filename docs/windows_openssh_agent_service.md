# 윈도우 OpenSSH 에이전트 서비스 (windows openssh agent service)

Windows 내장 OpenSSH 에이전트 서비스를 사용하면 Git Bash 세션에 종속되지 않고
SSH 키를 상시 관리할 수 있습니다.

## OpenSSH 클라이언트 설치 확인

PowerShell(관리자)에서 설치 여부를 확인합니다.

```powershell
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Client*'
```

`NotPresent`이면 설치합니다.

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```

## 에이전트 서비스 활성화

PowerShell(관리자)에서 서비스를 자동 시작으로 설정하고 즉시 시작합니다.

```powershell
Set-Service -Name ssh-agent -StartupType Automatic
Start-Service ssh-agent
```

서비스 상태를 확인합니다.

```powershell
Get-Service ssh-agent
```

```
Status   Name               DisplayName
------   ----               -----------
Running  ssh-agent          OpenSSH Authentication Agent
```

## SSH 키 등록

PowerShell에서 키를 에이전트에 등록합니다.

```powershell
ssh-add $env:USERPROFILE\.ssh\id_ed25519
```

등록된 키 목록을 확인합니다.

```powershell
ssh-add -l
```

Windows 재부팅 후에도 에이전트 서비스는 자동으로 시작되지만, 키는 다시 등록해야 합니다.

## 접속 확인

```powershell
ssh username@example.com
```
