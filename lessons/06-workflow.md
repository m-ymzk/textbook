# 06 実践ワークフロー

## 目的
- 一般的なチームワークフロー（Feature ブランチ、PR ベースの開発）を学ぶ

## フロー例
1. `main` は常にデプロイ可能な状態を保つ
2. 機能ごとに `feature/*` ブランチを作成
3. PR を作成しレビュー後にマージ
4. リリースは `release/*` ブランチやタグで管理

## 練習課題
- 典型的な機能追加→PR→レビュー→マージの流れを再現する

## 詳細（初心者向け）

### 代表的なワークフロー

- Git Flow: `develop` と `main`（または `master`）を使い、`feature/*`, `release/*`, `hotfix/*` を分けて管理する。大規模プロジェクトで有用だがやや複雑。
- GitHub Flow: シンプルに `main`（または `trunk`）を中心に feature ブランチを切り、PR でマージする。CI を通して main にマージする運用が前提。
- Trunk-based Development: 頻繁に短い-lived ブランチを作り、頻繁に main/trunk に統合する。リリースはタグで管理する。

選択はチーム規模やリリース方針で決める。初心者には GitHub Flow を推奨します。

### CI / 自動テストの統合
- PR 作成時に自動でテストや linters、ビルドが走るように CI（例: GitHub Actions）を設定する。これにより品質を担保できる。
- 簡単な `workflow` の例（GitHub Actions）:

```yaml
name: CI
on: [push, pull_request]
jobs:
	build:
		runs-on: ubuntu-latest
		steps:
			- uses: actions/checkout@v4
			- name: Set up Python
				uses: actions/setup-python@v4
				with:
					python-version: '3.11'
			- name: Install dependencies
				run: pip install -r requirements.txt
			- name: Run tests
				run: pytest -q
```

### リリースとバージョン管理
- リリースはタグ（例: `v1.0.0`）で管理する。タグ付けはローカルまたは CI で行える。

```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

### ホットフィックスの扱い
- `hotfix/*` ブランチを `main` から切って修正し、`main` にマージ、必要なら `develop` にもマージする（Git Flow の場合）。

### チェンジログとリリースノート
- 変更点は `CHANGELOG.md` に要約して残す。自動生成ツール（`github-changelog-generator` 等）を使うと便利。

### コードレビューの運用ルール例（簡易）
- 少なくとも1名以上のレビュー承認が必要
- テストがすべて成功すること（CI パス）をマージの条件とする
- 小さい PR（200 行未満）を推奨

### ローカルでの一般的な作業手順（例）

```bash
# 最新の main を取得
git checkout main
git fetch origin
git pull origin main

# 新しいフィーチャーブランチを作成
git switch -c feature/your-feature

# 作業してコミット
git add .
git commit -m "Add feature"

# リモートに push して PR を作成
git push -u origin feature/your-feature
```

### ブランチのクリーンアップ
- マージ済みローカルブランチは `git branch -d feature/xxx`
- リモートブランチは `git push origin --delete feature/xxx`

### セキュリティとアクセス管理（簡易）
- 機密情報はリポジトリに含めない（`.gitignore` と秘密管理ツールを使用）
- `main` ブランチ保護ルールで必須レビューやステータスチェックを必須にする

---

次は `07 トラブルシューティング` を例付きで強化し、代表的な復旧手順を記載します。
