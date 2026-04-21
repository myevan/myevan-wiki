# 리눅스 배시 프로파일 (linux bash profile)

## 역할

| 파일 | 실행 시점 |
|------|----------|
| `~/.bash_profile` | 로그인 셸 시작 시 1회 |
| `~/.bashrc` | 인터랙티브 셸 시작 시마다 |

SSH 접속이나 터미널 로그인은 `~/.bash_profile`, 새 터미널 창/탭은 `~/.bashrc`가 실행됩니다.

## 기본 설정

`~/.bash_profile`이 없으면 경고가 발생하므로 생성하고 `~/.bashrc`를 불러오도록 설정합니다.

```bash
$ vim ~/.bash_profile
```

```bash
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
```

이후 환경 설정은 `~/.bashrc`에만 추가하면 로그인/인터랙티브 셸 모두에 적용됩니다.

## 적용

```bash
$ source ~/.bash_profile
```
