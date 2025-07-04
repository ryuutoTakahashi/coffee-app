# Coffee Tasting Evaluation API

COE (Cup of Excellence) カッピングシートに準拠したコーヒー味評価アプリケーションのバックエンド API です。

## 主な機能

- **COE準拠カッピング評価**: フレグランス/アロマ、フレーバー、アフターテイスト、酸味、ボディ、バランス、総合評価など
- **ユーザー管理**: 認証・認可、プロフィール管理
- **投稿機能**: コーヒー豆情報、抽出レシピ、画像添付
- **ソーシャル機能**: フォロー/フォロワー、いいね、コメント
- **公開設定**: 非公開モード（個人記録）と公開モード（SNS機能）

## 技術スタック

- **Backend**: Java 21 + Spring Boot 3.2.x
- **Database**: PostgreSQL 15
- **Build Tool**: Maven
- **Security**: Spring Security + JWT
- **Cloud Storage**: AWS S3
- **Container**: Docker (開発環境)

## プロジェクト構成

```
src/
├── main/
│   ├── java/com/coffeetasting/
│   │   ├── entity/           # エンティティクラス
│   │   ├── repository/       # リポジトリインターフェース
│   │   ├── service/          # ビジネスロジック
│   │   ├── controller/       # REST API エンドポイント
│   │   ├── config/           # 設定クラス
│   │   ├── dto/              # データ転送オブジェクト
│   │   ├── security/         # セキュリティ関連
│   │   └── utils/            # ユーティリティ
│   └── resources/
│       ├── application.yml   # アプリケーション設定
│       └── static/           # 静的リソース
└── test/
    └── java/                 # テストコード
```

## セットアップ手順

### 前提条件

- Java 21
- Maven 3.9+
- Docker & Docker Compose（開発環境用）
- Make（任意 - コマンド簡素化のため）

### 🚀 クイックスタート（Makefileを使用）

#### 前提条件の確認
以下のツールがインストールされていることを確認してください：
- Java 21
- Maven 3.9+
- Docker & Docker Compose
- Make

> **Windows ユーザーの場合**: Chocolatey を使用して Make をインストールできます
> ```bash
> choco install make curl -y
> ```

#### セットアップ手順

```bash
# 1. プロジェクトクローン
git clone <repository-url>
cd coffee-app

# 2. 利用可能なコマンドを確認
make help

# 3. 初回セットアップ（データベース起動 + 依存関係インストール）
make setup

# 4. アプリケーション起動（開発モード）
make start

# 5. 動作確認（別ターミナルで実行）
make health
# 期待する出力: {"service":"Coffee Tasting API","version":"0.0.1-SNAPSHOT","status":"UP","timestamp":"..."}

# 6. システム全体のステータス確認
make status
```

#### 🎯 Postman でのテスト
1. ブラウザまたは Postman で以下のエンドポイントにアクセス:
   - Health Check: `http://localhost:8080/api/public/health`
2. レスポンスが正常に返されることを確認

#### よく使うコマンド

```bash
# アプリケーション制御
make start        # アプリ起動
make stop         # アプリ停止  
make restart      # 再起動
make health       # ヘルスチェック

# データベース管理
make db-up        # データベース起動（devプロファイル）
make db-down      # データベース停止
make db-reset     # データベースリセット
make db-logs      # データベースログ表示

# Docker 統合管理
make docker-start # フルスタック起動（アプリ + DB）
make docker-stop  # フルスタック停止
make docker-logs  # 全コンテナログ表示

# 開発・保守
make build        # アプリケーションビルド
make test         # テスト実行
make clean        # ビルド成果物クリーンアップ
make clean-all    # 全リソースクリーンアップ

# ショートカット
make s           # start
make h           # health  
make d           # db-up
make r           # restart
```

### 手動セットアップ（Makefileを使わない場合）

<details>
<summary>クリックして展開</summary>

### 1. プロジェクトクローン

```bash
git clone <repository-url>
cd coffee-tasting-app
```

### 2. データベース起動（開発環境）

```bash
# PostgreSQL と pgAdmin を起動（devプロファイル）
docker-compose --profile dev up -d

# データベース接続確認
# pgAdmin: http://localhost:5050
# Email: admin@coffeetasting.com
# Password: admin
```

### 3. アプリケーション起動

```bash
# 依存関係インストール
mvn clean install

# アプリケーション起動（開発プロファイル）
mvn spring-boot:run

# または本番プロファイルで起動
mvn spring-boot:run -Dspring-boot.run.profiles=prod
```

### 4. 動作確認

```bash
# ヘルスチェック
curl http://localhost:8080/api/public/health

# レスポンス例
{
  "status": "UP",
  "timestamp": "2024-01-15T10:30:00",
  "service": "Coffee Tasting API",
  "version": "0.0.1-SNAPSHOT"
}
```

</details>

## 💡 トラブルシューティング

### よくある問題と解決方法

**データベース接続エラー**
```bash
# データベースが起動していることを確認
make db-check

# データベースを再起動
make db-reset
```

**アプリケーションが起動しない**
```bash
# ポート8080が使用されていないことを確認
make stop

# 全リソースをクリーンアップして再セットアップ
make clean-all
make setup
```

**Make コマンドが見つからない（Windows）**
```bash
# Chocolatey経由でインストール
choco install make curl -y
refreshenv
```

## API エンドポイント概要

### 認証 API
- `POST /api/auth/login` - ログイン
- `POST /api/auth/register` - ユーザー登録
- `POST /api/auth/refresh` - トークン更新
- `DELETE /api/auth/logout` - ログアウト

### ユーザー管理 API
- `GET /api/users/profile` - プロフィール取得
- `PUT /api/users/profile` - プロフィール更新
- `GET /api/users/followers` - フォロワー一覧
- `POST /api/users/follow` - フォロー/アンフォロー

### コーヒー豆 API
- `GET /api/beans` - 豆一覧取得
- `POST /api/beans` - 豆情報登録
- `GET /api/beans/{id}` - 豆詳細取得
- `PUT /api/beans/{id}` - 豆情報更新

### カッピングセッション API
- `GET /api/sessions` - セッション一覧
- `POST /api/sessions` - セッション作成
- `GET /api/sessions/{id}` - セッション詳細
- `PUT /api/sessions/{id}` - セッション更新
- `DELETE /api/sessions/{id}` - セッション削除

### ソーシャル機能 API
- `POST /api/sessions/{id}/like` - いいね/取り消し
- `POST /api/sessions/{id}/comments` - コメント投稿
- `GET /api/sessions/{id}/comments` - コメント一覧
- `GET /api/feed` - タイムライン取得

### 画像アップロード API
- `POST /api/images/upload` - 画像アップロード
- `DELETE /api/images/{id}` - 画像削除

## 環境変数

### 開発環境
```env
DB_USERNAME=postgres
DB_PASSWORD=postgres
JWT_SECRET=your-jwt-secret-key
```

### 本番環境
```env
DATABASE_URL=jdbc:postgresql://your-db-host:5432/coffee_tasting_prod
DB_USERNAME=your-db-username
DB_PASSWORD=your-db-password
JWT_SECRET=your-production-jwt-secret
AWS_S3_BUCKET_NAME=your-s3-bucket
AWS_REGION=ap-northeast-1
CORS_ALLOWED_ORIGINS=https://your-frontend-domain.com
```

## データベーススキーマ

主要テーブル:
- `users` - ユーザー情報
- `coffee_beans` - コーヒー豆情報
- `cupping_sessions` - カッピングセッション
- `cupping_scores` - COE準拠評価スコア
- `session_images` - セッション画像
- `likes` - いいね情報
- `comments` - コメント
- `follows` - フォロー関係

### データベース接続情報
- **データベース名**: `coffee_tasting`
- **ユーザー名**: `postgres`
- **パスワード**: `postgres`
- **ホスト**: `localhost`
- **ポート**: `5432`

## 開発・テスト

```bash
# テスト実行
mvn test

# 統合テスト実行
mvn integration-test

# コードカバレッジ
mvn jacoco:report
```

## ライセンス

MIT License 