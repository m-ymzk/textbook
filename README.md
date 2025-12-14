# Git と GitHub（初心者向け）

このリポジトリは、Git と GitHub をこれから学ぶ方向けのハンズオン教材です。copilotに手伝ってもらって、Markdown形式にまとめました。

## 対象

- レベル: git / github の入門者
- 前提知識: linuxでの基本的なコマンドライン操作（`cd`, `ls`, `cat`）

## 目次

1. はじめに
2. 学習環境の準備（Git のインストール、GitHub アカウント作成）
3. Git 基本（リポジトリ、ステータス、コミット）
4. ブランチの基本（作成・切替・マージ）
5. リモートと GitHub（push, pull, fetch, origin）
6. プルリクエストとコードレビュー（GitHub 上の操作）
7. 実践ワークフロー（Feature ブランチ、レビュー、リリース）
8. トラブルシューティング（コンフリクト、revert, reset）
9. 練習問題（ローカル演習＋リモート演習）
10. 便利なコマンドチートシート
11. 参考資料・リンク

## はじめに（概要）

この教材の目的は、実際に手を動かしてGit/GitHubの基本操作を習得することです。各章は説明→実例→練習課題の順で構成します。

## クイックスタート（ローカルで手を動かす）

1. このフォルダに移動します:

```bash
cd /home/masa/figures/examples
```

2. セットアップスクリプトを実行して練習用リポジトリを作成します:

```bash
bash setup_demo.sh
```

スクリプトはローカルに `demo-practice` を作成し、サンプルコミットとブランチを用意します。

```mermaid
graph RL
	%% Remote repositories
	subgraph CR["クラウド (GitHub.com等)"]
		REM["リモートリポジトリ"]
	end

	%% Local PC2 area
	subgraph PC2["他の人の環境2"]
		direction TB
		LREP2["Local Repository"]
	end

	%% Local PC1 area
	subgraph PC1["他の人の環境1"]
		direction TB
		LREP1["Local Repository"]
	end

	%% Local PC area
	subgraph PC["手元の環境 (PC等)"]
		direction TB
		IDX["Staged"]
		MGX["conflicted"]
		LREP["Local Repository"]
	end

	%% Commands between components
	REM -->|clone| LREP
	REM -->|fetch| LREP
	LREP -->|push| REM
	REM -->|clone| LREP2
	REM -->|fetch| LREP2
	LREP2 -->|push| REM
	REM -->|clone| LREP1
	REM -->|fetch| LREP1
	LREP1 -->|push| REM
	LREP -->|add| IDX
	IDX -->|commit| LREP
	LREP -->|merge| MGX
	MGX -->|continue| LREP
	MGX -->|add| IDX
	IDX -->|commit| MGX

	%% Notes style
	classDef note fill:#939,stroke:#333,stroke-width:1px,color:#fff;
	class REM note
```

## 次のステップ

1. `lessons` の各章に目次の詳細アウトラインを反映（担当: 自分・目安: 1日）
2. `01 学習環境の準備` を完成させて動作確認（担当: 自分・目安: 半日）
3. `examples/setup_demo.sh` を使ってローカルでハンズオンを実行してみる（担当: 自分・目安: 30分）
