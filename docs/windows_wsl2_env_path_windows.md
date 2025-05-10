# WSL2 환경 변수 경로 윈도우 경로 제외 (Environment Path Excludes Windows Path)

<https://learn.microsoft.com/ko-kr/windows/wsl/wsl-config>

```
$ sudo vim /etc/wsl.conf

[interop]
appendWindowsPath=false

$ sudo reboot
```
