#!/bin/bash

# マージを試みる
git merge bbb

# マージの結果を確認
if [ $? -ne 0 ]; then
    echo "コンフリクトが発生しました！"
    
    # コンフリクト状態のファイルをリストアップ
    conflicted_files=$(git diff --name-only --diff-filter=U)
    
    if [ -z "$conflicted_files" ]; then
        echo "コンフリクトが検出されませんでした。"
    else
        echo "以下のファイルでコンフリクトが発生しました:"
        echo "$conflicted_files"

        # 各ファイルのコンフリクト部分を出力
        for file in $conflicted_files; do
            echo "==== $file のコンフリクト内容 ===="
            grep -n -E '(<<<<<<<|=======|>>>>>>>)' "$file"
            echo "=============================="
        done
    fi
else
    echo "マージが成功しました！"
fi
