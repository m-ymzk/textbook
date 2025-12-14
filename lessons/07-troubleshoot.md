# 07 トラブルシューティング

## 目的
- コンフリクトや誤コミットの取り消し方法を学ぶ

## 主なコマンドと使いどころ
- `git merge` でコンフリクトが出た場合の解消手順
- `git revert <commit>`：特定コミットの取り消し（安全）
- `git reset --hard <commit>`：履歴を戻す（注意）
- `git restore <file>`：作業ツリーの復元

## 練習課題
- コンフリクトを発生させて解消する演習

## 実例と手順（初心者向け）

### 1) マージコンフリクトの解消
状況: `feature` を `main` にマージしたときに同じファイルの異なる箇所が変更されている場合

手順:

```bash
# main に切替
git switch main
# リモートの最新を取得
git fetch origin
git merge origin/main

# マージを試みる
git merge feature/xxx
# コンフリクトがある場合、Git が該当ファイルを示す
```

1. エディタでコンフリクト箇所（<<<<<<<, =======, >>>>>>>）を確認して修正する
2. 修正後、`git add <file>` を実行
3. マージコミットを作成: `git commit`（自動でメッセージが用意される）

補足: コンフリクトの可視化ツールとして `git mergetool` を使うこともできます。

### 2) 誤って push したコミットを取り消したい（公開済みコミット）
- 安全な方法: `git revert <commit>` を使って、取り消し用の新しいコミットを作成します（履歴を書き換えない）。

```bash
git revert <bad_commit_hash>
git push origin main
```

### 3) 履歴を巻き戻してしまいたい（ローカルかつ未共有のコミット）
- `git reset --hard <commit>` は履歴を完全に戻します。リモートに既に push している場合は注意が必要です。

```bash
# 直近2つのコミットをなかったことにする例
git reset --hard HEAD~2
```

### 4) 間違って削除したブランチを復元したい

```bash
# 削除してしまったブランチ名: feature/old
# まず reflog で参照を探す
git reflog
# 復元したいコミットIDを見つけたら
git branch feature/old <commit_hash>
```

### 5) 失ったコミットを取り戻す（reflog）
- `git reflog` は HEAD の移動履歴を表示します。間違えて reset や checkout をしたときに便利です。

```bash
git reflog
# 目的の HEAD@{n} を見つけたら
git checkout -b recover-branch HEAD@{3}
```

### 6) 一時的に変更を退避させたい（stash の活用）

```bash
# 作業中の変更を退避
git stash push -m "WIP: implement feature"
# 退避リストを見る
git stash list
# 復元する
git stash apply stash@{0}
# もしくは取り出して削除
git stash pop
```

### 7) コミットを整理（インタラクティブリベース）
- 複数のコミットをまとめたり順序を直すとき

```bash
git rebase -i HEAD~5
# エディタで pick / squash などを操作
```

注意: 公開済みコミットをリベースすると他のコラボレータに影響が出る可能性があるため、チームルールに従うこと。

### 8) ファイル単位で前の状態に戻す

```bash
# 特定ファイルを直前のコミット状態に戻す（作業ツリー）
git restore <file>
# ステージ済みの変更を取り消す
git restore --staged <file>
```

### 9) よくあるエラーと対処のまとめ
- "detached HEAD": ブランチ名がない状態でコミットしている。`git switch -c new-branch` でブランチを作成して回避。
- `error: failed to push some refs`: リモートに新しいコミットがある。`git pull --rebase` 等で取り込んでから再度 push。
- 認証エラー: SSH 鍵や PAT の設定を確認。

---

次は `08 練習問題` に具体的な模範解答と手順（コマンド列）を追加します。
