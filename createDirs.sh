#!/bin/bash

# エラーを記録する一時ファイル
ERROR_LOG="create_dirs_error.log"
> "$ERROR_LOG"  # 初期化（空にする）

# ディレクトリ作成
while IFS=, read -r perms owner_group dirpath; do
    # 空行・コメント行はスキップ
    if [ -z "$dirpath" ]; then
        continue
    fi

    # ディレクトリ作成
    mkdir -p "$dirpath"
    if [ $? -ne 0 ]; then
        echo "mkdir failed: $dirpath" >> "$ERROR_LOG"
        continue
    fi

    # 所有者・グループの変更
    chown "$owner_group" "$dirpath" 2>>"$ERROR_LOG"
    if [ $? -ne 0 ]; then
        echo "chown failed: $dirpath" >> "$ERROR_LOG"
    fi

    # パーミッション変更
    chmod "$perms" "$dirpath" 2>>"$ERROR_LOG"
    if [ $? -ne 0 ]; then
        echo "chmod failed: $dirpath" >> "$ERROR_LOG"
    fi

done < dirlist.txt

# エラーレポート
if [ -s "$ERROR_LOG" ]; then
    echo "以下の処理でエラーが発生しました:"
    cat "$ERROR_LOG"
else
    echo "すべてのディレクトリを正常に作成・設定しました。"
    rm -f "$ERROR_LOG"
fi
