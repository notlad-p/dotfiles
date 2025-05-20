## Setup

- Install dependencies:

````

```sh
# this is only because types are broken with the latest version of typescript
# https://github.com/Aylur/astal/issues/313
npm i -D typescript@5.7.3
````

````


```sh
dateutils
````

- Create a `config.ts` in the root and add tomorrow.io API key:

```ts
const config = {
  tomorrowApiKey: "<api-key>",
};

export default config;
```

- Add `~/.face` profile picture image
- Make all scripts in the `scripts` directory executable

```sh
chmod +x ~/.config/ags/scripts/*.sh
```
