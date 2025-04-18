#!/usr/bin/bash

# .envファイルを読み込む
source .env

GAKUBU_LIST=$(printf "%s\n" A1 A2 A3 A4 A5 A6 A7 A8 A9 | shuf | sed 's/.*/          { "type": "TextBlock", "text": "&", "wrap": true },/')
M1_LIST=$(printf "%s\n" B1 B2 B3 B4 B5 | shuf | sed 's/.*/          { "type": "TextBlock", "text": "&", "wrap": true },/')
M2_LIST=$(printf "%s\n" C1 C2 C3 C4 C5 C6 | shuf | sed 's/.*/          { "type": "TextBlock", "text": "&", "wrap": true },/')

echo "学部生: $GAKUBU_LIST"
echo "M1: $M1_LIST"
echo "M2: $M2_LIST"

# 投稿
curl -s -i -H "Content-Type: application/json" --data-binary @- "$WEBHOOK_URL" << __EOF__
{
  "type": "message",
  "attachments": [
    {
      "contentType": "application/vnd.microsoft.card.adaptive",
      "contentUrl": null,
      "content": {
        "type": "AdaptiveCard",
        "version": "1.5",
        "msteams": {
          "width": "full"
        },
        "body": [
          {
            "type": "TextBlock",
            "text": "今日の発表順（ランダム）",
            "wrap": true
          },
          {
            "type": "Container",
            "style": "accent",
            "bleed": true,
            "items": [
              {
                "type": "ColumnSet",
                "columns": [
                  { "type": "Column", "width": "stretch", "items": [{ "type": "TextBlock", "text": "学部生", "wrap": true }] },
                  { "type": "Column", "width": "stretch", "items": [{ "type": "TextBlock", "text": "M1", "wrap": true }] },
                  { "type": "Column", "width": "stretch", "items": [{ "type": "TextBlock", "text": "M2", "wrap": true }] }
                ]
              }
            ]
          },
          {
            "type": "Container",
            "spacing": "None",
            "items": [
              {
                "type": "ColumnSet",
                "spacing": "None",
                "columns": [
                  {
                    "type": "Column",
                    "width": "stretch",
                    "items": [
$GAKUBU_LIST
                    ]
                  },
                  {
                    "type": "Column",
                    "width": "stretch",
                    "items": [
$M1_LIST
                    ]
                  },
                  {
                    "type": "Column",
                    "width": "stretch",
                    "items": [
$M2_LIST
                    ]
                  }
                ]
              }
            ]
          }
        ]
      }
    }
  ]
}
__EOF__
