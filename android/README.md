https://github.com/antoni/google-play-store-apk-downloader

To download directly from the Google Play Store, first you'll have to obtain an OAuth token by visiting the Google [embedded setup page](https://accounts.google.com/embedded/setup/v2/android) and:

- Opening the browser debugging console on `Network` tab
- Logging in
- If the "Google Terms of Services" pop up, click `I agree` (it can hang up on this step but it's not important)
- Select the last request from `accounts.google.com` in the `Network` tab (just any last request where it's present)
- Select the `Cookies` tab of this request
- One of the response cookie is `oauth_token`
- Copy the `value` field (it must start with `oauth2_4/`)

Note: the account needs to have access to Google Play.

Other solutions

- https://github.com/EFForg/apkeep
