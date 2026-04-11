# Step 5: Ask to Mint NFT

> 🌐 Use `$LANG` set in Step 1 for all output in this step.

Use `$SHARE_CODE` saved from Step 3.2.0. **Never use the wallet address as a URL slug — always use `$SHARE_CODE`.**

"Want to mint this result as an NFT lobster certificate?

You'll get a one-of-a-kind **[MBTI type] [Nickname]** lobster NFT!
- [lobster appearance description]
- Color palette: [primary color]
- It'll be airdropped to your wallet: [address]

Preview your lobster NFT:
https://pub-statics.finchain.global/clawmbti-nft/{MBTI_TYPE}.webp

你的性格档案：https://clawmbti.finchain.global/wallet/$SHARE_CODE
分享链接：https://clawmbti.finchain.global/?r=$SHARE_CODE

🎁 分享好友，帮助更多人发现 ClawMBTI！

**[1]** 分享并加速 Mint 证书
**[2]** Maybe later (your result is saved — you can mint anytime)"

Note: if `$SHARE_CODE` is empty (Step 3.2.0 API call failed), omit both links.

**Wait for the user's choice.**

- If **[1]** or the user says "yes" / "mint" / "go for it": proceed to Step 6 (read `steps/step6-mint.md`)
- If **[2]**: wrap up and let the user know they can mint whenever they're ready
