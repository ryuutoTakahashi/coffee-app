# マルチステージビルド - ビルドステージ
FROM openjdk:21-jdk-slim as builder

WORKDIR /app

# Mavenのキャッシュ効率化のため、pom.xmlを先にコピー
COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn

# 依存関係をダウンロード（キャッシュ効率のため）
RUN ./mvnw dependency:go-offline -B

# ソースコードをコピー
COPY src src

# アプリケーションをビルド
RUN ./mvnw clean package -DskipTests

# 実行ステージ
FROM openjdk:21-jre-slim

WORKDIR /app

# アプリケーションユーザーを作成
RUN addgroup --system spring && adduser --system spring --ingroup spring

# タイムゾーンを設定
RUN apt-get update && apt-get install -y tzdata curl && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    rm -rf /var/lib/apt/lists/*

# jarファイルをコピー
COPY --from=builder /app/target/*.jar app.jar

# ユーザーを変更
USER spring:spring

# ヘルスチェック
HEALTHCHECK --interval=30s --timeout=3s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:8080/api/public/health || exit 1

# アプリケーション起動
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"] 