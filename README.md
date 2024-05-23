# nmk-vender

Vendoring tmux and zsh for nmk.

## How to

1. start tmuxinator session using `./start-tmuxinator`
2. edit last line of `./build-and-run-in-tmux` then run it

## Update default channel

After you build new set of vendor file, if you want make uploaded folder as default, use following command

```sh
gcloud storage objects update gs://nmk.nuimk.com/nmk-vendor/ \
    --custom-metadata=x-default-vendor-channel=YOUR_NEW_FOLDER_FOR_EXAMPLE_tmux-3.4-zsh-5.9-slim
```

