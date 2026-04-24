# 윈도우 Git Bash에서 WSL 접근하기 (windows git bash wsl)

## 문제: 경로 자동 변환

Git Bash는 `/home/...` 같은 Unix 경로를 Windows 경로로 자동 변환합니다.

```
/home/myevan/Works → C:/Program Files/Git/home/myevan/Works
```

따라서 `wsl` 명령에 Unix 경로를 그대로 넘기면 WSL이 아닌 Git Bash 루트 기준으로 해석됩니다.

## 해결: MSYS_NO_PATHCONV=1

`MSYS_NO_PATHCONV=1` 환경변수를 앞에 붙이면 경로 자동 변환을 막을 수 있습니다.

```bash
$ MSYS_NO_PATHCONV=1 /c/Windows/System32/wsl.exe -u myevan ls /home/myevan
```

`wsl` 대신 `/c/Windows/System32/wsl.exe` 절대경로를 사용하는 이유는 Git Bash PATH에 `wsl.exe`가 없는 경우가 있기 때문입니다.

## 별칭 등록

매번 타이핑하기 번거로우므로 `~/.bashrc`에 별칭을 등록합니다.

```bash
$ vim ~/.bashrc
```

```bash
# WSL 접근 (경로 자동 변환 방지)
alias wsl='MSYS_NO_PATHCONV=1 /c/Windows/System32/wsl.exe'
```

적용합니다.

```bash
$ source ~/.bashrc
```

이후 아래처럼 간단히 사용할 수 있습니다.

```bash
$ wsl -u myevan ls /home/myevan/Works
```

## 특정 사용자로 실행

`-u` 옵션으로 WSL 사용자를 지정합니다.

```bash
$ wsl -u myevan bash -c "cd /home/myevan/Works/myproject && make"
```
