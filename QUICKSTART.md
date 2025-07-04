# ⚡ クイックスタートガイド

Coffee Tasting APIを最速で起動する手順です。

## 🚀 30秒で起動

### Windows PowerShell（推奨）
```powershell
# 1. 初回セットアップ（データベース起動 + 依存関係インストール）
.\dev.ps1 setup

# 2. アプリケーション起動
.\dev.ps1 start
```

### Make（英語版に更新済み）
```bash
# 1. 初回セットアップ（データベース起動 + 依存関係インストール）
make setup

# 2. アプリケーション起動
make start
```

**たったこれだけ！** 🎉

## 📋 よく使うコマンド

### PowerShell版
```powershell
# ヘルプ表示（全コマンド一覧）
.\dev.ps1 help

# 初回セットアップ
.\dev.ps1 setup

# アプリケーション起動
.\dev.ps1 start          # 開発モード
.\dev.ps1 start-prod     # 本番モード

# ヘルスチェック
.\dev.ps1 health

# ステータス確認
.\dev.ps1 status

# アプリケーション停止
.\dev.ps1 stop

# 再起動
.\dev.ps1 restart
```

### Make版
```bash
# ヘルプ表示（全コマンド一覧）
make help

# 初回セットアップ
make setup

# アプリケーション起動
make start          # 開発モード
make start-prod     # 本番モード

# ヘルスチェック
make health

# ステータス確認
make status

# アプリケーション停止
make stop

# 再起動
make restart
```

## 🗄️ データベース管理

```bash
# データベース起動
make db-up

# データベース停止
make db-down

# データベースリセット
make db-reset

# データベース接続
make db-connect

# データベースログ確認
make db-logs

# データベース接続確認
make db-check
```

## 🔨 開発・テスト

```bash
# ビルド
make build

# テスト実行
make test

# 統合テスト
make test-int

# 依存関係更新確認
make update

# クリーンアップ
make clean
```

## 📊 監視・確認

```bash
# ヘルスチェック
curl http://localhost:8080/api/public/health

# または
make health

# システム全体のステータス確認
make status
```

## 🔧 便利なエイリアス

短縮コマンドも使えます：

```bash
make s    # start
make b    # build  
make t    # test
make h    # health
make d    # db-up
make r    # restart
```

## 🎯 開発フロー例

```bash
# 1. 初回セットアップ
make setup

# 2. 開発開始
make start

# 3. 別ターミナルでヘルスチェック
make health

# 4. テスト実行
make test

# 5. コード変更後の再起動
make restart

# 6. 作業終了
make stop
make db-down
```

## 🌐 アクセス情報

| サービス | URL | 認証情報 |
|---------|-----|---------|
| API | http://localhost:8080 | - |
| ヘルスチェック | http://localhost:8080/api/public/health | - |
| pgAdmin | http://localhost:5050 | admin@coffeetasting.com / admin |
| PostgreSQL | localhost:5432 | postgres / postgres |

## 🆘 トラブルシューティング

### **Makefileエラー（Windows）**
**症状**: `process_begin: CreateProcess(NULL, echo データベースを起動中..., ...) failed.`

**解決策**: PowerShellスクリプトを使用してください：
```powershell
# Makeの代わりにPowerShellを使用
.\dev.ps1 setup   # make setup の代わり
.\dev.ps1 start   # make start の代わり
```

### Windows環境での文字化け対応
- PowerShellのエンコーディングを設定：
  ```powershell
  [Console]::OutputEncoding = [Text.Encoding]::UTF8
  chcp 65001
  ```

### アプリケーションが起動しない
**PowerShell版:**
```powershell
# データベース状況確認
.\dev.ps1 status

# 完全リセット
.\dev.ps1 db-reset
```

**Make版:**
```bash
# ログ確認
make logs

# データベース状況確認
make status

# 完全リセット
make dev-reset
```

### データベース接続エラー
```bash
# データベース再起動
make db-reset

# 接続確認
make db-check

# 手動接続テスト
make db-connect
```

### ポート競合エラー
```bash
# Windows でポート使用状況確認
netstat -ano | findstr :8080
netstat -ano | findstr :5432

# プロセス停止
make stop
make db-down
```

### Docker関連エラー
```bash
# Docker状況確認
docker ps -a

# Docker ログ確認
make db-logs

# Docker 完全リセット
make clean-all
```

## 💡 Windows環境での注意点

1. **PowerShell推奨**: コマンドプロンプトよりもPowerShellを使用してください
2. **Docker Desktop**: Docker Desktopが起動していることを確認
3. **権限**: 管理者権限が必要な場合があります
4. **エンコーディング**: UTF-8に設定してください

## 🎉 次のステップ

アプリが起動したら：

1. **API仕様確認**: `README.md` のAPI一覧を確認
2. **認証機能実装**: JWT認証の実装
3. **カッピング機能実装**: COE準拠のスコア評価機能
4. **画像アップロード実装**: S3連携機能
5. **フロントエンド連携**: Nuxt3アプリとの接続

開発を楽しんでください！ ☕️✨ 