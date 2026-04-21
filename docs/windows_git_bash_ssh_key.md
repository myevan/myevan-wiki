# 윈도우 Git Bash SSH 키 만들기 (windows git bash ssh key)

## 키 생성

ED25519 알고리즘으로 SSH 키를 생성합니다.

```bash
$ ssh-keygen -t ed25519 -C "user@example.com"
```

키 저장 경로와 패스프레이즈를 묻습니다. 경로는 기본값을 사용하고, 패스프레이즈는 보안을 위해 설정하는 것을 권장합니다.

```
Generating public/private ed25519 key pair.
Enter file in which to save the key (/c/Users/user/.ssh/id_ed25519): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /c/Users/user/.ssh/id_ed25519
Your public key has been saved in /c/Users/user/.ssh/id_ed25519.pub
```

## SSH 에이전트 자동 실행

bash 시작 시 에이전트가 없으면 자동으로 실행되도록 `~/.bashrc`에 추가합니다.
에이전트 소켓 경로를 `~/.ssh/agent.env`에 저장해 비인터랙티브 셸에서도 재사용합니다.

```bash
$ vim ~/.bashrc
```

```bash
# ssh-agent 자동 실행
SSH_AGENT_ENV="$HOME/.ssh/agent.env"

if [ -f "$SSH_AGENT_ENV" ]; then
    source "$SSH_AGENT_ENV" > /dev/null
fi

if ! ssh-add -l &>/dev/null; then
    ssh-agent -s > "$SSH_AGENT_ENV"
    chmod 600 "$SSH_AGENT_ENV"
    source "$SSH_AGENT_ENV" > /dev/null
    ssh-add ~/.ssh/id_ed25519
fi
```

설정을 즉시 적용합니다.

```bash
$ source ~/.bashrc
```

## 비인터랙티브 셸 설정

스크립트나 외부 도구에서 실행되는 비인터랙티브 bash도 에이전트를 사용할 수 있도록 `~/.bash_profile`에 추가합니다.

Git for Windows가 자동 생성한 `~/.bash_profile`은 이미 `~/.bashrc`를 소싱합니다. 여기에 `BASH_ENV`만 추가합니다.

```bash
$ vim ~/.bash_profile
```

```bash
export BASH_ENV="$HOME/.ssh/agent.env"
```

## 서버에 공개 키 등록

원격 서버에 공개 키를 복사합니다.

```bash
$ ssh-copy-id user@remote.server
```

직접 추가할 경우 서버의 `~/.ssh/authorized_keys` 파일에 공개 키 내용을 붙여넣습니다.

```bash
$ cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
$ chmod 600 ~/.ssh/authorized_keys
```

## 접속 확인

```bash
$ ssh user@remote.server
```
