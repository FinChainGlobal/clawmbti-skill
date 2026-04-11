# Step 0: Environment Check (Silent)

Run the following silently — no output to the user. Only speak up if something goes wrong.

## Check and initialize the environment

First check if uv is available:

```bash
uv --version
```

**If `uv --version` fails** (command not found), tell the user:

"You'll need to install the `uv` package manager first:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```
Once that's done, just trigger this again."

Then **stop** — do not continue to subsequent steps.

Now sync dependencies. **Before running, tell the user:**

"⚙️ Setting up environment… (first time may take ~30 seconds)"

```bash
uv sync --quiet
```

**If `uv sync` fails**, tell the user: "Dependency setup failed. Check your network connection and try again." Then stop.

Once the environment is ready, **proceed directly to Step 1 without any further message**.
