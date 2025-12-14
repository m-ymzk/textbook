#!/usr/bin/env bash
set -euo pipefail

# demo-practice リポジトリを作成し、練習用のコミットとブランチを用意するスクリプト
# 実行: bash setup_demo.sh

ROOT=$(pwd)
DEMO_DIR="demo-practice"

if [ -d "$DEMO_DIR" ]; then
  echo "既に $DEMO_DIR が存在します。既存のリポジトリを削除して再作成します。"
  rm -rf "$DEMO_DIR"
fi

mkdir -p "$DEMO_DIR"
cd "$DEMO_DIR"

# Git 初期化
git init

echo "# Demo Practice" > README.md
echo "Line 1" > conflict.txt
mkdir -p src
cat > src/hello.py <<'PY'
def hello():
    return "Hello from demo"

if __name__ == '__main__':
    print(hello())
PY

git add .
git commit -m "Initial commit: README, conflict.txt, src/hello.py"

git branch -M main

# feature/hello ブランチを作って簡単なファイルを追加
git switch -c feature/hello
echo "Feature Hello" > hello.txt
git add hello.txt
git commit -m "Add hello.txt on feature/hello"

# main に戻って conflict 用の変更を加える
git switch main
# ここでは conflict.txt に main 側の変更を追加
printf "Line main change\n" >> conflict.txt
git add conflict.txt
git commit -m "Update conflict.txt on main"

# feature/conflict ブランチを作り、同じファイルに別の変更を加える（コンフリクト用）
git switch -c feature/conflict
printf "Line feature change\n" >> conflict.txt
git add conflict.txt
git commit -m "Change conflict.txt on feature/conflict"

# 戻る
git switch main

cat <<EOF
セットアップ完了: $(pwd)/${DEMO_DIR}
- ブランチ一覧:
  $(git branch --format='%(refname:short)')

次の操作例:
- コンフリクト試験: git merge feature/conflict を main で実行してみてください。
- feature の内容確認: git switch feature/hello && ls -la

注意: このスクリプトはローカル操作のみ行います（リモートに push しません）。
EOF

# 戻る
cd "$ROOT"
