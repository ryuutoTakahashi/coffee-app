# Coffee Tasting API - Postman Collection

このディレクトリには、Coffee Tasting APIをテストするためのPostmanコレクションと環境ファイルが含まれています。

## 📁 ファイル構成

```
postman/
├── Coffee-Tasting-API.postman_collection.json    # APIコレクション
├── Coffee-Tasting-API.postman_environment.json   # 環境設定
└── README.md                                      # このファイル
```

## 🚀 セットアップ手順

### 1. Postmanにインポート

1. **Postmanを開く**
2. **Import** ボタンをクリック
3. **Upload Files** を選択
4. 以下の2つのファイルを選択してインポート：
   - `Coffee-Tasting-API.postman_collection.json`
   - `Coffee-Tasting-API.postman_environment.json`

### 2. 環境設定の選択

1. Postman右上の環境選択ドロップダウンから
2. **"Coffee Tasting API - Development"** を選択

## 🧪 テスト実行順序

### Step 1: ヘルスチェック ✅
```
🔥 Health Check → Health Check
```
アプリケーションが正常に動作していることを確認

### Step 2: ユーザー認証 🔐
```
🔐 Authentication → Register User  (新規ユーザー登録)
🔐 Authentication → Login User     (ログイン・認証トークン取得)
```

### Step 3: コーヒー豆データ作成 ☕
```
☕ Coffee Beans → Create Coffee Bean     (コーヒー豆登録)
☕ Coffee Beans → Get All Coffee Beans   (一覧取得)
☕ Coffee Beans → Get Coffee Bean by ID  (詳細取得)
```

### Step 4: カッピングセッション作成 🥤
```
🥤 Cupping Sessions → Create Cupping Session      (セッション作成)
🥤 Cupping Sessions → Get Public Cupping Sessions (公開セッション一覧)
🥤 Cupping Sessions → Get My Cupping Sessions     (自分のセッション一覧)
🥤 Cupping Sessions → Get Cupping Session by ID   (セッション詳細)
```

### Step 5: COEスコア評価 📊
```
📊 COE Cupping Scores → Create COE Cupping Score           (スコア作成)
📊 COE Cupping Scores → Get Cupping Score by Session ID    (スコア取得)
📊 COE Cupping Scores → Update Cupping Score               (スコア更新)
```

### Step 6: 画像アップロード 📸
```
📸 Session Images → Upload Session Image  (画像アップロード)
📸 Session Images → Get Session Images    (画像一覧取得)
```

### Step 7: ソーシャル機能 ❤️👥
```
❤️ Likes & Comments → Like Session        (いいね)
❤️ Likes & Comments → Add Comment         (コメント追加)
❤️ Likes & Comments → Get Session Comments (コメント一覧)
👥 Social Features → Follow User          (フォロー)
👥 Social Features → Get User Followers   (フォロワー一覧)
```

## 🔧 環境変数

設定済みの環境変数：

| 変数名 | デフォルト値 | 説明 |
|--------|-------------|------|
| `baseUrl` | `http://localhost:8080` | APIベースURL |
| `apiPrefix` | `/api` | 認証が必要なAPIプレフィックス |
| `publicPrefix` | `/api/public` | 公開APIプレフィックス |
| `authPrefix` | `/api/auth` | 認証関連APIプレフィックス |
| `username` | `testuser` | テスト用ユーザー名 |
| `email` | `test@example.com` | テスト用メールアドレス |
| `password` | `password123` | テスト用パスワード |

自動設定される変数：
- `authToken` - ログイン後に自動設定
- `userId` - ユーザー登録/ログイン後に自動設定
- `sessionId` - セッション作成後に自動設定
- `coffeeBeanId` - コーヒー豆作成後に自動設定

## 📊 COEカッピングスコア評価項目

```json
{
    "fragranceAroma": 8.5,     // フラグランス/アロマ (0-10点)
    "flavor": 8.75,            // フレーバー (0-10点)
    "aftertaste": 8.25,        // アフターテイスト (0-10点)
    "acidity": 8.5,            // 酸味 (0-10点)
    "body": 8.0,               // ボディ (0-10点)
    "balance": 8.25,           // バランス (0-10点)
    "sweetness": 8.5,          // 甘さ (0-10点)
    "cupCleanliness": 8.75,    // カップクリーンリネス (0-10点)
    "overall": 8.5,            // 全体評価 (0-10点)
    "defects": 0               // 欠点豆数
}
```

## 🧪 自動テスト機能

一部のリクエストには自動テストスクリプトが含まれています：

- **ヘルスチェック**: ステータスコード200とstatus="UP"をチェック
- **認証**: レスポンスデータから自動的にトークンやIDを環境変数に設定
- **データ作成**: 作成されたリソースのIDを自動的に環境変数に保存

## 🔍 トラブルシューティング

### 認証エラー (401 Unauthorized)
```
→ Login Userを実行してauthTokenを取得してください
```

### サーバー接続エラー
```
→ アプリケーションが起動していることを確認
→ .\dev.ps1 health でヘルスチェック実行
```

### 環境変数が設定されない
```
→ 環境が正しく選択されているか確認
→ リクエスト実行後にTestsタブでスクリプトエラーをチェック
```

## 💡 使用のコツ

1. **順序を守る**: 認証 → データ作成 → 操作の順番で実行
2. **環境変数確認**: 各リクエスト実行後に環境変数タブで値が設定されているか確認
3. **テスト機能活用**: Test Results で自動テストの結果を確認
4. **エラー詳細確認**: レスポンスタブでエラーメッセージを確認

## 🚀 高度な使い方

### Collection Runner使用
1. コレクション右の「...」→「Run collection」
2. 実行したいフォルダを選択
3. 「Run Coffee Tasting API」で一括実行

### Newman (CLI)使用
```bash
# Newmanインストール
npm install -g newman

# コレクション実行
newman run Coffee-Tasting-API.postman_collection.json \
  -e Coffee-Tasting-API.postman_environment.json
``` 