# 우분투 파이썬 환경 따라하기 (ubuntu pyenv tutorial)

## 준비

pyenv 에 필요한 패키지들을 미리 설치합니다.

<https://github.com/pyenv/pyenv/wiki/Common-build-problems>

```bash
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
```

## 설치

pyenv 간편 설치 스크립트를 실행합니다.

<https://github.com/pyenv/pyenv-installer>

```bash
curl https://pyenv.run | bash
```

## 설정

pyenv 설정을 추가 합니다.

```bash
$ vim ~/.bashrc
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

터미널에 재접속하면 pyenv 를 사용할 수 있습니다.

## 파이썬 설치

```bash
$ pyenv install 3.11.0
$ pyenv versions
$ pyenv shell 3.11.0
```

## 로컬 버전 선택

```bash
$ pyenv local 3.11.0
```

## 가상 환경 생성 

```bash
$ python -m venv .venv
```

## 가상 환경 실행

```bash
$ .venv/bin/python
```

## 가상 환경 패키지 매니저

```bash
$ .venv/bin/pip
```
