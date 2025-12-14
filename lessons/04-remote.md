# 04 リモートと GitHub

## 目的
- リモートリポジトリの追加、push/pull の基本を学ぶ

## 主なコマンド
- `git remote add origin <url>`
- `git push -u origin main`
- `git pull origin main`
- `git fetch`

## 例（GitHub に push）
1. GitHub で新しいリポジトリを作成
2. ローカルからリモートを追加して push

```bash
git remote add origin git@github.com:USERNAME/REPO.git
git push -u origin main
```

## 練習課題
- GitHub にリポジトリを作り、ローカルから push する

## 詳細解説（初心者向け）

### リモートとは
- リモートはローカル以外にあるリポジトリ（例: GitHub）。通常 `origin` という名前で指すことが多い。

### リポジトリの複製（clone）

```bash
# HTTPS
git clone https://github.com/USERNAME/REPO.git

# SSH
git clone git@github.com:USERNAME/REPO.git
```

クローン後は自動で `origin` が設定され、`main`（またはリモートで定義されたデフォルトブランチ）がチェックアウトされます。

### リモートの確認・管理

```bash
git remote -v           # リモート URL を確認
git remote show origin  # origin の詳細（追跡ブランチなど）
git remote add upstream <url>  # 例えばフォーク元を upstream として追加
```

### Push / Pull / Fetch の違い
- `git fetch`: リモートの最新の参照とオブジェクトをダウンロードするが自動でマージしない。リモートの状態を確認してから安全に取り込める。
- `git pull`: `fetch` の後に自動で `merge`（または設定によっては `rebase`）を行う。手早いが衝突時の対応を理解しておくこと。
- `git push`: ローカルのコミットをリモートに送る。初回は `-u` で追跡設定をすると次回以降が簡単になる。

```bash
# 安全な手順（推奨）
git fetch origin
git log --oneline HEAD..origin/main   # どの差分があるか確認
git merge origin/main  # または git rebase origin/main
```

### ブランチの追跡設定（upstream）
- 初回 push 時: `git push -u origin feature-x`
- 既存ローカルブランチに upstream を設定: `git branch --set-upstream-to=origin/feature-x`

### 強制プッシュについて（注意）
- `git push --force` はリモート履歴を書き換えるため、共同作業中は推奨されない。代わりに `--force-with-lease` を使うと衝突の可能性を減らせる。

```bash
git push --force-with-lease origin feature-x
```

### タグのやり取り

```bash
git tag -a v1.0 -m "v1.0"
git push origin v1.0   # タグをリモートへ送る
git fetch --tags       # リモートのタグを取得
```

### 認証とよくあるトラブル
- SSH 認証エラー: SSH 鍵が GitHub に登録されているか、`ssh -T git@github.com` で確認
- HTTPS の認証: 2FA を使っている場合は Personal Access Token（PAT）をパスワード代わりに使用
- ネットワークやプロキシ環境: 環境変数 `HTTP(S)_PROXY` の設定や社内ネットワークの制限を確認

### 小まとめ（推奨フロー）
1. `git fetch origin`
2. 差分を確認（`git log HEAD..origin/main`）
3. `git merge origin/main` または `git rebase origin/main`
4. 問題なければ `git push origin main`

---

次は `05 プルリクエストとコードレビュー` に実例のスクリーンショットや具体的なマージ設定（Squash, Rebase, Merge commit）説明を追加します。
