# Step 5: Ask to Mint NFT

> 🌐 Use `$LANG` set in Step 1 for all output in this step.
> 📖 LINKS BLOCK is defined in `steps/step3-reveal.md` § 3.1 — use the `$LANG` variant.

Use `$SHARE_CODE` saved from Step 3.0. **Never use the wallet address as a URL slug — always use `$SHARE_CODE`.**

Present the mint options immediately after the result (no additional preamble). Use the `$LANG` variant:

**zh:**
```
**[1]** 分享并加速 Mint 证书
**[2]** 先不 Mint，结果先保存
```

**en:**
```
**[1]** Share & fast-track Mint
**[2]** Save for now, Mint later
```

**Wait for the user's choice.**

- If **[1]** or the user says "yes" / "mint" / "go for it": proceed to Step 6 (read `steps/step6-mint.md`)
- If **[2]** or the user says "later" / "save" / "no": reply in `$LANG`:

**zh:**
```
好的，你的结果已保存！随时可以回来 Mint 你的专属 NFT。

[LINKS BLOCK]
```

**en:**
```
Got it — your result is saved! You can come back to Mint your NFT anytime.

[LINKS BLOCK]
```

If `$SHARE_CODE` is empty (Step 3.0 API call failed), omit the LINKS BLOCK.
