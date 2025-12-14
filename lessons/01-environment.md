# 01 学習環境の準備

## 目的
- Git をインストールし、GitHub アカウントを用意する
- Git の初期設定（ユーザ名、メール）を行う

## 手順（Linux / macOS）
1. Git のインストール

```bash
# Debian/Ubuntu
sudo apt update && sudo apt install git -y

# macOS (Homebrew)
brew install git
```

2. Git の動作確認

```bash
git --version
```

3. 初期設定

```bash
git config --global user.name "あなたの名前"
git config --global user.email "you@example.com"
```

## GitHub アカウント作成
- https://github.com/ でサインアップ
- SSH キーの作成と登録（任意）

## 練習
- `git --version` を実行してバージョンを確認
- `git config --list` で設定を確認

## 追加：詳細手順と補足（初心者向け）

### OS別インストール（補足）
- Debian/Ubuntu: `sudo apt install git`（既に書かれている通り）
- Fedora/RHEL: `sudo dnf install git` または `sudo yum install git`
- Windows: https://git-scm.com/download/win から "Git for Windows" をインストール（GUI/ターミナル同梱）

### SSH 鍵の作成と GitHub 登録（推奨）

1. SSH 鍵を作る（既存の鍵を使う場合はこの手順をスキップ）

```bash
ssh-keygen -t ed25519 -C "you@example.com"
# 既に ed25519 に対応していない環境では rsa を使う
# ssh-keygen -t rsa -b 4096 -C "you@example.com"
```

2. 公開鍵を GitHub に登録する

```bash
# 公開鍵の表示（クリップボードにコピー）
cat ~/.ssh/id_ed25519.pub
# または macOS の場合
pbcopy < ~/.ssh/id_ed25519.pub
```

3. GitHub の `Settings` → `SSH and GPG keys` → `New SSH key` に公開鍵を貼り付ける

### HTTPS と Personal Access Token（代替）
- HTTPS で push/pull する際、2FA を使っている場合は Personal Access Token（PAT）が必要です。PAT は GitHub の `Settings` → `Developer settings` → `Personal access tokens` で発行します。

### 推奨 Git 設定例

```bash
git config --global core.editor "code --wait"
git config --global pull.rebase false
git config --global init.defaultBranch main
git config --global credential.helper cache # 一時的なキャッシュ
```

### テスト手順（SSH 接続確認）

```bash
ssh -T git@github.com
# 初回はホスト鍵の確認を求められます。"yes" を入力すると接続テストが行われます。
```

### よくある問題と対処
- Git が見つからない: パスにインストールされているか確認（`which git`）
- SSH 鍵が拒否される: GitHub に正しい公開鍵を登録したか確認、`ssh -vT git@github.com` でデバッグ

---

次は `02 Git 基本` を拡充して、具体的なコマンド例と演習手順を追加します。
