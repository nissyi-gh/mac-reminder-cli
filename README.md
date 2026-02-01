# mac-reminder-cli

macOS のリマインダーをターミナルから操作する CLI ツール。

## 必要環境

- macOS 14 (Sonoma) 以上
- Swift 6.0 以上

## インストール

```bash
git clone https://github.com/nissyi-gh/mac-reminder-cli.git
cd mac-reminder-cli
swift build -c release
cp .build/release/rem /usr/local/bin/
```

## 使い方

### リマインダー一覧を表示

```bash
rem list
```

未完了のリマインダーを一覧表示します。

### リマインダーを追加

```bash
rem add "買い物に行く"
```

新しいリマインダーを追加します。

### ヘルプ

```bash
rem --help
rem list --help
rem add --help
```

## 初回実行時

初回実行時にリマインダーへのアクセス許可を求められます。「許可」を選択してください。

## 開発

```bash
# ビルド
swift build

# テスト
swift test

# 実行
swift run rem list
```
