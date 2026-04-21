# 리눅스 SSH 키 만들기 (linux ssh key)

## 키 생성

ED25519 알고리즘으로 SSH 키를 생성합니다.

```bash
$ ssh-keygen -t ed25519 -C "user@example.com"
```

키 저장 경로와 패스프레이즈를 묻는데, 기본값 사용 시 엔터를 누릅니다.

```
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/user/.ssh/id_ed25519): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/user/.ssh/id_ed25519
Your public key has been saved in /home/user/.ssh/id_ed25519.pub
```

## SSH 에이전트 자동 실행

bash 시작 시 에이전트가 없으면 자동으로 실행되도록 `~/.bashrc`에 추가합니다. `~/.bash_profile` 설정은 [리눅스 배시 프로파일](/linux_bash_profile)을 참고합니다.

```bash
$ vim ~/.bashrc
```

```bash
# ssh-agent 자동 실행
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
fi
```

설정을 즉시 적용합니다.

```bash
$ source ~/.bashrc
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

## 권한 설정

`.ssh` 디렉토리와 키 파일의 권한이 잘못되면 접속이 거부됩니다.

```bash
$ chmod 700 ~/.ssh
$ chmod 600 ~/.ssh/id_ed25519
$ chmod 644 ~/.ssh/id_ed25519.pub
```
