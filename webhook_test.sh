#!/usr/bin/bash

# .envファイルを読み込む
source .env

# 投稿テスト
curl -s -i -H "Content-Type: application/json" --data-binary @- "$WEBHOOK_URL" << '__EOF__'
   {
      "type":"message",
      "attachments":[
         {
            "contentType":"application/vnd.microsoft.card.adaptive",
            "contentUrl":null,
            "content":{
               "$schema":"http://adaptivecards.io/schemas/adaptive-card.json",
               "type":"AdaptiveCard",
               "version":"1.4",
               "body":[
                  {
                     "type": "TextBlock",
                     "text": "Hello World"
                  }
               ]
            }
         }
      ]
   }
__EOF__