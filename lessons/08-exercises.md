# 08 練習問題

## 課題例
1. 新規リポジトリを作成し、README を追加してコミット・push する
2. feature ブランチで変更を加え、PR を作成してマージする
3. 意図的にコンフリクトを作って解消する

## 回答例
- 各課題に対するコマンド例と期待される結果を別途記載します（次フェーズ）

## 模範解答と手順（コマンド列）

### 課題1: 新規リポジトリの作成と push

1) ローカルでリポジトリ作成と初期コミット

```bash
mkdir demo-repo && cd demo-repo
echo "# Demo Repo" > README.md
git init
git add README.md
git commit -m "Initial commit: add README"
```

2) GitHub で空のリポジトリ `demo-repo` を作成し、リモートを追加して push

```bash
git remote add origin git@github.com:YOUR_USER/demo-repo.git
git push -u origin main
```

確認:
- GitHub のリポジトリページに `README.md` が表示される
- `git remote -v` で origin が設定されている

### 課題2: feature ブランチで PR を作成してマージ

1) feature ブランチ作成と作業

```bash
git switch -c feature/add-intro
echo "Intro text" > intro.md
git add intro.md
git commit -m "Add intro.md"
git push -u origin feature/add-intro
```

2) GitHub 上で PR を作成し、レビュー・承認後にマージ（UI で操作）

CLI での PR 作成例（`gh` がインストールされている場合）:

```bash
gh auth login
gh pr create --base main --head feature/add-intro --title "Add intro" --body "説明: intro を追加しました"
```

3) マージ後、ローカルで main を更新

```bash
git switch main
git pull origin main
# マージ済みブランチの削除
git branch -d feature/add-intro
git push origin --delete feature/add-intro
```

確認:
- `git log --oneline` にマージコミットまたは squash の結果が反映されている

### 課題3: コンフリクトを発生させて解消する

1) 準備: リポジトリの main を最新にする

```bash
git switch main
git pull origin main
```

2) 片方のブランチで変更

```bash
git switch -c feature/conflict-a
echo "Line A" >> conflict.txt
git add conflict.txt
git commit -m "Add line A"
git push -u origin feature/conflict-a
```

3) もう一方（main）で同じファイルの同じ行を変更してコミット

```bash
git switch main
echo "Line B" >> conflict.txt
git commit -am "Add line B on main"
git push origin main
```

4) feature ブランチを main にマージしてコンフリクト発生

```bash
git switch main
git merge feature/conflict-a
# Git がコンフリクトを報告する
```

5) 解消手順

```bash
# エディタで conflict.txt を開き、<<<<<<< / ======= / >>>>>>> を手で修正
git add conflict.txt
git commit -m "Resolve conflict between main and feature/conflict-a"
git push origin main
```

確認:
- `git status` がクリーンになる
- GitHub の main に修正が反映される

---

他にも練習問題を追加できます（rebase 練習、revert 演習、stash 演習など）。続けて追加しますか？
