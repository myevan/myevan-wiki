# 윈도우 Claude Code 셋업 (windows claude code setup)

### 전역 설정

`~/.claude/CLAUDE.md`에 전역 지시를 추가합니다.

```markdown
# 전역 설정

## Windows 실행 파일
Bash에서 .bat, .exe 실행 시 `cmd /c`를 거치지 않고 직접 실행한다.

## Windows SSH
SSH 명령은 Bash 대신 PowerShell 툴로 실행한다.

```

## SSH 에이전트 연동

Claude Code가 SSH를 통해 원격 서버에 접근하려면 에이전트가 필요합니다.

Windows 내장 OpenSSH 에이전트 서비스를 사용하면 Git Bash 세션에 종속되지 않습니다.
자세한 설정 방법은 [윈도우 OpenSSH 에이전트 서비스](windows_openssh_agent_service.md)를 참고합니다.

PowerShell(관리자)에서 서비스를 활성화합니다.

```powershell
Set-Service -Name ssh-agent -StartupType Automatic
Start-Service ssh-agent
ssh-add $env:USERPROFILE\.ssh\id_ed25519
```
