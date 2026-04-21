# myevan-wiki

개인 게임 개발 지식을 틈틈이 모아두는 위키.

## 프로젝트 구조

- **빌드**: MkDocs (Material 테마) 기반 정적 사이트
- **배포**: GitHub Pages (`myevan.github.io`)
- **문서**: `docs/` 디렉토리 아래 마크다운 파일
- **네비게이션**: `mkdocs.yml`의 `nav` 섹션에서 관리

## 문서 카테고리

| 카테고리 | 경로 패턴 | 주제 |
|---------|----------|------|
| OS | `docs/mac_*`, `docs/ubuntu_*`, `docs/windows_*`, `docs/synology_*` | macOS, Ubuntu, Windows, NAS 환경설정 |
| 게임엔진 | `docs/ue4_*` | Unreal Engine 4 빌드/설정/플러그인/네트워크 |
| VCS | `docs/git_*`, `docs/helix_*`, `docs/gitlab_*` | Git, Perforce/Helix |
| 에디터 | `docs/vscode_*`, `docs/vim_*` | VSCode, Vim |
| 문서화 | `docs/*mkdocs*`, `docs/github_io_*` | MkDocs, GitHub Pages |
| 기타 | `docs/python_tcod.md`, `docs/emscripten_*` | 게임 관련 라이브러리 |

## 새 문서 추가 시

1. `docs/` 에 마크다운 파일 작성
2. `mkdocs.yml`의 `nav` 섹션에 항목 추가
3. 파일명 규칙: `{플랫폼}_{주제}_{세부주제}.md` (예: `ue4_windows_build_editor.md`)

## 로컬 서버 실행

```bash
./vmkdocs_serve.sh   # macOS/Linux
vmkdocs_serve.bat    # Windows
```

## 배포

```bash
./vdeploy.sh
```
