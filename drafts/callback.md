今回読んでいくコードは [Google Sheets API v4 の Node.js Quickstart](https://developers.google.com/sheets/api/quickstart/nodejs#step_3_set_up_the_sample)

いちおうこれさえあれば Sheets API をつかった簡単な CLI アプリがつくれるというものらしいが、JavaScript 歴 1 週間なのでよくわからん。

認証とスプレッドシートの操作がセットになってしまっているので、それをバラして認証のモジュールと各機能のモジュールに分けたい。

全体像はこんな感じ。

```JavaScript
const fs = require("fs");
const readline = require("readline");
const { google } = require("googleapis");

// If modifying these scopes, delete token.json.
const SCOPES = ["https://www.googleapis.com/auth/spreadsheets.readonly"];
// The file token.json stores the user's access and refresh tokens, and is
// created automatically when the authorization flow completes for the first
// time.
const TOKEN_PATH = "token.json";

// Load client secrets from a local file.
fs.readFile("credentials.json", (err, content) => {
    if (err) return console.log("Error loading client secret file:", err);
    // Authorize a client with credentials, then call the Google Sheets API.
    authorize(JSON.parse(content), listMajors);
});

/**
 * Create an OAuth2 client with the given credentials, and then execute the
 * given callback function.
 * @param {Object} credentials The authorization client credentials.
 * @param {function} callback The callback to call with the authorized client.
 */
function authorize(credentials, callback) {
    const { client_secret, client_id, redirect_uris } = credentials.installed;
    const oAuth2Client = new google.auth.OAuth2(
        client_id,
        client_secret,
        redirect_uris[0]
    );

    // Check if we have previously stored a token.
    fs.readFile(TOKEN_PATH, (err, token) => {
        if (err) return getNewToken(oAuth2Client, callback);
        oAuth2Client.setCredentials(JSON.parse(token));
        callback(oAuth2Client);
    });
}

/**
 * Get and store new token after prompting for user authorization, and then
 * execute the given callback with the authorized OAuth2 client.
 * @param {google.auth.OAuth2} oAuth2Client The OAuth2 client to get token for.
 * @param {getEventsCallback} callback The callback for the authorized client.
 */
function getNewToken(oAuth2Client, callback) {
    const authUrl = oAuth2Client.generateAuthUrl({
        access_type: "offline",
        scope: SCOPES,
    });
    console.log("Authorize this app by visiting this url:", authUrl);
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
    });
    rl.question("Enter the code from that page here: ", (code) => {
        rl.close();
        oAuth2Client.getToken(code, (err, token) => {
            if (err)
                return console.error(
                    "Error while trying to retrieve access token",
                    err
                );
            oAuth2Client.setCredentials(token);
            // Store the token to disk for later program executions
            fs.writeFile(TOKEN_PATH, JSON.stringify(token), (err) => {
                if (err) return console.error(err);
                console.log("Token stored to", TOKEN_PATH);
            });
            callback(oAuth2Client);
        });
    });
}

/**
 * Prints the names and majors of students in a sample spreadsheet:
 * @see https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit
 * @param {google.auth.OAuth2} auth The authenticated Google OAuth client.
 */
function listMajors(auth) {
    const sheets = google.sheets({ version: "v4", auth });
    sheets.spreadsheets.values.get(
        {
            spreadsheetId: "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms",
            range: "Class Data!A2:E",
        },
        (err, res) => {
            if (err) return console.log("The API returned an error: " + err);
            const rows = res.data.values;
            if (rows.length) {
                console.log("Name, Major:");
                // Print columns A and E, which correspond to indices 0 and 4.
                rows.map((row) => {
                    console.log(`${row[0]}, ${row[4]}`);
                });
            } else {
                console.log("No data found.");
            }
        }
    );
}
```

おおまかに全体像をつかむと

- モジュールやトークンなど必要なものを読み込む
- OAuth 2.0
  - 既存のトークンが見当たらなければ作成
- スプレッドシートをいじる

というようにみえる。できるだけ丁寧によんでいきたい。

***

```JavaScript
const fs = require("fs");
const readline = require("readline");
const { google } = require("googleapis");

const SCOPES = ["https://www.googleapis.com/auth/spreadsheets.readonly"];
const TOKEN_PATH = "token.json";
```

## [require(id)](https://nodejs.org/docs/latest-v13.x/api/modules.html#modules_require_id)

- id \<string> module name or path
- Returns: \<any> exported module content

Package Manager Tips などにもあるとおり JSON やローカルファイルの読み込みにつかわれる。

パッとみたところ注意すべきなのは相対パスの名前解決は

- ワーキングディレクトリに対して行われる

ということぐらい。つまり、ファイルの置いてある場所との相対パスではないということ（一敗）。

## [File System](https://nodejs.org/docs/latest-v13.x/api/fs.html#fs_file_system)

`fs` モジュールでファイルをあつかうことができる。つかうときは

```JavaScript
const fs = require("fs");
```

すべてのファイルシステム操作には[同期処理と非同期処理](https://jsprimer.net/basic/async/)がある。

- `Synchronous : ` 同期処理は他の処理の終了を待って実行する
- `Asynchronous:` 非同期処理は他の処理の終了を待たず並列に実行する

非同期処理は常に最後の引数でコールバックの完了をうけとる。コールバックがどういうことかを調べるのはあとまわし。

最初の引数はエラーをうけとる。正常終了した場合は `null` か `undefined` をうけとる。

同期処理は `try...catch` で例外処理をおこなう。

## [try...catch](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Statements/try...catch)

```JavaScript
try {
    // 期待される処理
}
catch (error_1) {
    // 例外処理1
}
catch (error_2) {
    // 例外処理2
}
...
finally {
    // 常に実行される処理
}
```

- `try...catch`
- `try...finally`
- `try...catch...finally`

いずれでもよい（関係ないが MDN はいちおう公式扱いしてよい情報だとおもうけど「例外を投げる」という言葉遣いはリファレンスとしてどうなんだ）。

非同期処理は他の処理の終了を待たないので

1. `/tmp/hello` を `/tmp/world` にリネームする（`fs.rename()`）
2. `/tmp/world` の存在を確認する（`fs.stat()`）

と続けた処理をすると、存在を確認する処理が先に実行されてしまいエラーになることがある。

そこでコールバックをつかって解決する

- コールバック関数は、関数の引数になる関数（コールされる関数）

```JavaScript
fs.rename('/tmp/hello', '/tmp/world', (err) => {
    if (err) throw err;
    fs.stat('/tmp/world', (err, stats) => {
        if (err) throw err;
        console.log(`stats: ${JSON.stringify(stats)}`);
    });
});
```

この場合は `fs.stat()` が `fs.rename()` を引数にもつので、`fs.rename()` がコールバック関数になる。

`fs.rename()` がエラーを吐いた場合、`fs.stat()` は引数でエラーをうけとるので実行されない。

コールバック関数の省略はバグの温床なのでやめましょうと書いてある。

非同期処理で不都合が起きるなら同期処理すればいいじゃんとおもったけど、同期処理は全体のプロセスを完全に止めてしまうとのこと。なるほど。

```JavaScript
const { google } = require("googleapis");
```

変数が `{}` で囲まれているのは[分割代入](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment)というらしい。

モジュールから `google` という名前のプロパティだけを代入しているということ。

残りの 2 行は API の使用範囲とトークンを変数に入れてる。

***

```JavaScript
fs.readFile("credentials.json", (err, content) => {
    if (err) return console.log("Error loading client secret file:", err);
    authorize(JSON.parse(content), listMajors);
});
```

トークンを要求するのに必要な[クレデンシャル](https://qiita.com/TakahikoKawasaki/items/200951e5b5929f840a1f#4-%E3%82%AF%E3%83%A9%E3%82%A4%E3%82%A2%E3%83%B3%E3%83%88%E3%82%AF%E3%83%AC%E3%83%87%E3%83%B3%E3%82%B7%E3%83%A3%E3%83%AB%E3%82%BA%E3%83%95%E3%83%AD%E3%83%BC) `credentials.json` を事前にダウンロードしてある前提。

ファイルがなければそこでおしまい。

ファイルがあれば内容を変数 `content` に格納し、関数 `authorize` に投げている。

`listMajors` はスプレッドシートをいじる関数。`authorize` にコールされている。

`authorize` の実行が完了すると `authorize` が実行されるという流れ。

## [JSON.parse()](https://ja.javascript.info/json#ref-120)

引数として受け取った文字列を JSON として解釈し、文字列や配列などのオブジェクトに変換してくれる。

第二引数にオプションとして `reviver` 関数をとることができる。

オブジェクトを返す前に `reviver` を通して変換される。

```JavaScript
let str = '{"title":"Conference","date":"2017-11-30T12:00:00.000Z"}';
let meetup = JSON.parse(str);
alert(meetup.date.getDate()); // Error!
```

`meetup.date` はこのままだと値が文字列になってしまい `Date` オブジェクトでないため、`getDate()` できずエラーになる。

そこで `reviver` を通して変換する。

```JavaScript
let str = '{"title":"Conference","date":"2017-11-30T12:00:00.000Z"}';
let meetup = JSON.parse(str, function(key, value) {
    if (key == 'date') return new Date(value);
    return value;
});
alert(meetup.date.getDate());
```

無名関数のなかで型変換してエラーが起きなくなった。

`==` をつかっているのは `reviver` を通すと JSON 文字列が配列型で返ってくるからだとおもわれる。

Sheets API の場合は JSON 文字列は渡された先の関数でも JSON 文字列のままつかわれている。

***

```JavaScript
function authorize(credentials, callback) {
    const { client_secret, client_id, redirect_uris } = credentials.installed;
    const oAuth2Client = new google.auth.OAuth2(
        client_id,
        client_secret,
        redirect_uris[0]
    );

    fs.readFile(TOKEN_PATH, (err, token) => {
        if (err) return getNewToken(oAuth2Client, callback);
        oAuth2Client.setCredentials(JSON.parse(token));
        callback(oAuth2Client);
    });
}
```

さっき

```JavaScript
authorize(JSON.parse(content), listMajors);
```

で呼び出されていた `authorize` が定義されている。

`credentials`、要するに `credential.json` からいろいろ呼び出してクライアント情報を作成している。

つづいて

- トークンが作成されていなければ `getNewToken` 関数へ
- 作成済みならばクライアント情報にトークンを追加

さいごに `callback` つまり `listMajors` へ `oAuth2Client` を渡している。

`listMajors` は `getNewToken` のコールバックにもなっている。

***

```JavaScript
function getNewToken(oAuth2Client, callback) {
    const authUrl = oAuth2Client.generateAuthUrl({
        access_type: "offline",
        scope: SCOPES,
    });
    console.log("Authorize this app by visiting this url:", authUrl);
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
    });
    rl.question("Enter the code from that page here: ", (code) => {
        rl.close();
        oAuth2Client.getToken(code, (err, token) => {
            if (err)
                return console.error(
                    "Error while trying to retrieve access token",
                    err
                );
            oAuth2Client.setCredentials(token);
            fs.writeFile(TOKEN_PATH, JSON.stringify(token), (err) => {
                if (err) return console.error(err);
                console.log("Token stored to", TOKEN_PATH);
            });
            callback(oAuth2Client);
        });
    });
}
```

トークン生成の過程は流石に端折りたい。流れは認可サーバへの URL を生成してユーザにアクセスと認証コードのコピペを促し、トークンをクライアント情報に追加というかんじ。最後にその認証情報を `callback` つまり `listMajors` に渡している。

[JSON.stringify()](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify) はオブジェクトや値を JSON 文字列に変換している。

`listMajors` はスプレッドシートをいじる部分。みてもしょうがないので省略。おしまい。

***

やってることは雰囲気で感じた通りだったけど、コールバックがわからなかったのでなんじゃこりゃという感じだった。

丁寧に見ていったら、クレデンシャルを読んでそれぞれの関数にスプレッドシートをいじる関数を渡しつつ認証情報を埋めていってるだけだった。

まとめておく。

スプレッドシートをいじる関数をバケツリレーしながら以下のように認証を進める。

1. クレデンシャルを読む
   1. クレデンシャルがなければ異常終了
2. 認証情報を追加しトークンを読む
   1. トークンがあれば
      1. 認証情報にトークンを追加
   2. トークンがなければ
      1. ユーザにトークンを生成させる
      2. 認証情報にトークンを追加
3. スプレッドシートを操作

ということはモジュール化してスプレッドシートをいじる関数を投げるようにすればいいのかな。ちょっとやってみよう。