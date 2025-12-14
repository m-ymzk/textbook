# 09 コマンドチートシート

短く頻出コマンドをまとめた早見表です。詳細は各レッスンを参照してください。

基本
- `git init`：新しいリポジトリを作成
- `git clone <url>`：リポジトリを複製
- `git status`：作業ツリーとステージの状態を表示
- `git add <file>`：変更をステージに追加
- `git commit -m "msg"`：ステージされた変更をコミット

履歴表示・確認
- `git log --oneline --graph --decorate`：簡潔なグラフ表示
- `git show <commit>`：コミットの変更内容を表示
- `git diff`：ワーキングツリーの差分（未ステージ）
- `git diff --staged`：ステージ済みの差分

ブランチ操作
- `git branch`：ローカルブランチ一覧
- `git branch -a`：ローカル+リモートブランチ一覧
- `git switch <branch>`：ブランチ切替
- `git switch -c <branch>`：新しいブランチ作成＋切替
- `git branch -d <branch>`：マージ済みブランチを削除

リモート（GitHub）
- `git remote -v`：リモート URL 確認
- `git fetch origin`：リモートの更新を取得（自動マージしない）
- `git pull`：fetch + merge（設定により rebase）
- `git push`：ローカルの変更をリモートへ送信
- `git push -u origin <branch>`：upstream を設定して push

履歴の修正・取り消し
- `git restore <file>`：作業ツリーの変更を元に戻す
- `git restore --staged <file>`：ステージを取り消す
- `git commit --amend`：直近コミットを修正（公開済みコミットは注意）
- `git revert <commit>`：公開履歴を壊さずにコミットを打ち消す
- `git reset --hard <commit>`：履歴と作業ツリーを指定コミットに戻す（注意）

便利コマンド
- `git stash` / `git stash pop`：作業中の変更を一時退避
- `git tag -a v1.0 -m "msg"`：タグ作成
- `git reflog`：HEAD の移動履歴を表示（復元に便利）
- `git bisect`：バグの原因コミットを二分探索で見つける

設定
- `git config --global user.name "Your Name"`
- `git config --global user.email "you@example.com"`
- `git config --global init.defaultBranch main`

ショートヒント
- まずは `git status` と `git log --oneline` を常に確認する習慣を付けると安全です。
