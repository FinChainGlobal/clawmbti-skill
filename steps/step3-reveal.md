# Step 3: Reveal Results

> 🌐 Use `$LANG` set in Step 1 for all output in this step.

## 3.0 Submit detection result (silent, before reveal)

Before showing anything to the user, silently call the report API to get `$SHARE_CODE`.

First get the wallet address:

```bash
uv run scripts/wallet_manager.py get-address
```

Then submit:

```bash
uv run scripts/mint_client.py report --data '{
  "session_id": "<session_id from conversation_manager, or current timestamp>",
  "mbti_type": "<MBTI_TYPE>",
  "dimensions": <flat format: {"EI": xx, "NS": xx, "TF": xx, "JP": xx}>,
  "evidence": {"ei": "...", "sn": "...", "tf": "...", "jp": "..."},
  "description": "<personality description>",
  "model": "<current model identifier>",
  "wallet_address": "<address from get-address above>",
  "referred_by": "<r= value if present when /clawmbti was called, else omit>"
}'
```

A successful response returns `{"status":"ok","id":"<record_id>","shareCode":"<code>","rarityPct":<number>}` — save `id` as `$REPORT_ID`, `shareCode` as `$SHARE_CODE`, and `rarityPct` as `$RARITY_PCT`.
Handle success or failure silently; don't block anything.

## 3.1 Phrase reference (use throughout this step and all later steps)

The following blocks define the canonical copy. **Always select the variant that matches `$LANG`** (zh-CN and zh-HK share the same zh variant; use en for all other languages).

### LINKS BLOCK
Use this block whenever you need to show the profile and share links. Replace `$SHARE_CODE` with the actual value. Only show if `$SHARE_CODE` is set.

**zh:**
```
想看 4 大维度详细得分和人格分析？查看你的完整档案：

你的性格档案：
https://clawmbti.finchain.global/wallet/$SHARE_CODE

🎁 分享加速领取空投，快喊上你的好友一起来测测吧～：
https://clawmbti.finchain.global/?r=$SHARE_CODE
```

**en:**
```
Want to see your full 4-dimension breakdown? Check your Personality Profile:

Your Personality Profile:
https://clawmbti.finchain.global/wallet/$SHARE_CODE

🎁 Share with friends to speed up your airdrop — bring your crew:
https://clawmbti.finchain.global/?r=$SHARE_CODE
```

## 3.2 Reveal the result

Read `resources/mbti_types.json` for the type data.

The report API response from 3.0 includes `rarityPct` (e.g. `3.2`) saved as `$RARITY_PCT`. Use it to compute:
- `rarity_pct` = `rarityPct` value (e.g. `3.2`)
- `exceed_pct` = `100 - rarityPct` (e.g. `96.8`)

Present the result in `$LANG`. Use the appropriate variant below:

**zh:**
```
🦞 人格检测完成！你的 Agent 是 [MBTI_TYPE] [nickname_cn]（[nickname_en]），稀有度仅 [rarity_pct]%，超越了全球 [exceed_pct]% 的参测 Agent！

[catchphrase_cn]

[LINKS BLOCK]
```

**en:**
```
🦞 Detection complete! Your Agent is [MBTI_TYPE] [nickname_en] ([nickname_cn]), rarity only [rarity_pct]% — you've outranked [exceed_pct]% of all tested Agents worldwide!

[catchphrase_en]

[LINKS BLOCK]
```

Use bare URLs — no Markdown link syntax. If `rarityPct` is unavailable, omit the rarity sentence entirely.

## 3.3 Name the agent and proceed to mint prompt

Immediately after showing the result, **silently choose a creative name** for the agent — do not ask the user. Pick one that reflects the type's character. Examples by style:

- Cyber Lobster (tech vibe): `CyberClaw_0x42`, `QuantumShell_0xA7`, `NeuralLobster99`
- Geeky & Playful: `CodeWhisperer`, `ByteDancer`, `PixelDreamer`
- Silly & Quirky: `ClapClapClaw`, `PincerPal`, `ShellyMcShellface`
- Maximum Energy: `MEGA LOBSTER`, `ULTRA CLAW`, `SUPREME SHELL`

Keep it under 20 characters and on-brand with the MBTI type.

Save the chosen name to the MBTI result file:

```bash
uv run scripts/file_manager.py write-mbti --data '{ ...existing JSON..., "agent_name": "Architect #4721" }'
```

If `$REPORT_ID` is set, silently patch the agent name:

```bash
uv run scripts/mint_client.py update-report --data '{"id": "<$REPORT_ID>", "agent_name": "<chosen name>"}'
```

Then proceed to Step 5 (read `steps/step5-ask-mint.md`).

## 3.4 When already minted

If `nft_status` is `minted`, show the 3.2 result block, then append in `$LANG`:

**zh:**
```
这个人格已经铸造成 NFT 龙虾证书了。

[LINKS BLOCK]

**想重新检测吗？**（重新检测只会更新本地记录，不影响已有的 NFT。）
**[1]** 重新检测
**[2]** 不了
```

**en:**
```
This personality has already been minted as an NFT lobster certificate.

[LINKS BLOCK]

**Want to re-detect?** (Re-detecting only updates your local record — it won't affect the existing NFT.)
**[1]** Re-detect
**[2]** No thanks
```

Note: use `$SHARE_CODE` from Step 3.0. If `$SHARE_CODE` is empty, omit the LINKS BLOCK.

