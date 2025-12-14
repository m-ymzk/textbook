# 03 ブランチの基本

## 目的
- `git branch <name>`（作成）
- `git switch <name>` または `git checkout <name>`（切替）
- `git merge <branch>`（マージ）

## 例
```bash
# ブランチ作成と切替
git branch feature-x
git switch feature-x
# 作業してコミット
# main に戻ってマージ
git switch main
git merge feature-x

## 詳細解説（初心者向け）

### ブランチとは
- ブランチは独立した作業線（並行して開発できる履歴の枝）です。
- `main`（旧 `master`）は通常、安定版を示します。

### よく使う操作
- ブランチ作成と切替（一行で）: `git switch -c feature-x`
- 現在のブランチ確認: `git branch --show-current` または `git status`
- ローカルブランチの削除: `git branch -d feature-x`（マージ済みの場合）、強制削除は `-D`

### リモートブランチとのやり取り
- ブランチをリモートに push: `git push -u origin feature-x`（初回は `-u` をつけて追跡設定）
- リモートのブランチ一覧取得: `git fetch` と `git branch -r` または `git ls-remote`

### マージの方法と注意点
- `git merge <branch>`：通常のマージ（マージコミットが作成される）
- `git rebase <branch>`：履歴を付け替える。履歴がきれいになるが公開済みコミットに対しては注意が必要
- コンフリクト発生時はファイルを編集してから `git add`、`git commit`（マージ時）または `git rebase --continue`（リベース時）を実行

### ブランチ戦略（簡易）
- Feature ブランチ: `feature/*`
- バグ修正: `bugfix/*`
- リリース: `release/*`、タグ `v1.0.0` を併用

## ハンズオン演習（手順）

1. 新しいリポジトリで初期コミットを作る

```bash
mkdir branch-demo && cd branch-demo
echo "# Branch Demo" > README.md
git init
git add README.md
git commit -m "Initial commit"
```

2. `feature` ブランチを作って変更をコミットする

```bash
git switch -c feature/hello
echo "Hello feature" > hello.txt
git add hello.txt
git commit -m "Add hello.txt on feature branch"
```

3. `main` に戻って別変更を作る（コンフリクトを起こす準備）

```bash
git switch main
echo "Hello from main" >> README.md
git commit -am "Update README on main"
```

4. `feature` を `main` にマージしてみる

```bash
git switch main
git merge feature/hello
# もしコンフリクトが起きたら、該当ファイルをエディタで修正してから:
git add <conflicted-file>
git commit
```

5. リモートにプッシュする（ローカルにリモートがある想定）

```bash
git remote add origin git@github.com:USERNAME/REPO.git  # 既にある場合は不要
git push -u origin main
git push -u origin feature/hello
```

---

次は `04 リモートと GitHub` の演習を強化します（push/pull/fetch の流れと注意点）。

## 練習課題
- feature ブランチを作って変更をマージする
