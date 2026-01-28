function nix-maintain
    set -l action $argv[1]

    switch $action
        case update
            echo "🔄 Updating flake inputs..."
            nix flake update

        case rebuild
            echo "⚙️ Rebuilding and switching system..."
            sudo nixos-rebuild switch --flake .#shizuru

        case clean
            echo "🧹 Cleaning system generations..."
            sudo nix-collect-garbage -d
            sudo nix store gc

        case boot
            echo "🧹 Removing old boot entries..."
            sudo bootctl remove
            sudo bootctl update

        case all
            echo "🏁 Full maintenance: update, rebuild, clean, boot"
            nix flake update
            sudo nixos-rebuild switch --flake .#shizuru
            sudo nix-collect-garbage -d
            sudo nix store gc
            sudo bootctl remove
            sudo bootctl update

        case '*'
            echo "Usage: nix-maintain [update | rebuild | clean | boot | all]"
    end
end
