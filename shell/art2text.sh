#!/usr/bin/env bash

direrr() {
    echo -e "\e[41m[ERROR] You should run me under \e[1;33mthe root of this repository.\e[0m"
    exit 1
}

[[ -d "art" ]] || direrr
[[ -d "text" ]] || direrr

for doc in art/*.md
do
    echo Converting "'${doc:4}'" ...
    raw_doc=$(cat $doc)
    new_doc=${raw_doc//$'\n'/'\n'}
    cat > "text/${doc:4:-3}.html" <<EOF
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="♂DO YOU LIKE VAN YOU SEE ?♂">
    <link rel="icon" href="/static/favicon.ico">
    <title>ArticleBox | HAVE A LOOK</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1.5.0/css/pico.min.css">
    <link rel="stylesheet" href="/static/style.css">
    <style>
        #view {
            text-align: left;
        }
    </style>
</head>
<body>
    <main class="container">
        <h1>ArticleBox | <a href="/text">图片</a></h1>
        <article id="view">
        <div id="content"></div>
        <script src="https://cdn.bootcdn.net/ajax/libs/marked/4.3.0/marked.min.js"></script>
        <script>
          document.getElementById('content').innerHTML =
            marked.parse('"$new_doc"');
EOF
    cat >> "text/${doc:4:-3}.html" <<EOF
        </script>
        </article>
        <footer id="footer">
            <p>————————————没了————————————</p>
        </footer>
    </main>
</body>
</html>
EOF
done
