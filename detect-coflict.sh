#!/bin/bash

# マージを試みる
git merge pull

# pull コマンドの結果を確認
if [ $? -ne 0 ]; then
    echo "PULL中にエラーが発生しました（コンフリクトの可能性あり）!"
    
    # コンフリクト状態のファイルをリストアップ
    conflicted_files=$(git diff --name-only --diff-filter=U)
    
    if [ -z "$conflicted_files" ]; then
        echo "コンフリクトファイルが検出されませんでした。"
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
    echo "PULLとマージが成功しました!"
fi