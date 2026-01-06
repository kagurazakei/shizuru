{pkgs, ...}: {
  hm.programs.git = {
    enable = true;
    package = pkgs.gitFull;
    lfs = {
      enable = true;
      skipSmudge = true;
    };

    settings = {
      user.name = "kagurazakei";
      user.email = "maotsugiri@gmail.com";
      init.defaultBranch = "main";
      core = {
        pager = "delta";
        askPass = "";
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
      };
      alias = {
        br = "branch";
        c = "commit -m";
        ca = "commit -am";
        co = "checkout";
        d = "diff";
        df = "!git hist | peco | awk '{print $2}' | xargs -I {} git diff {}^ {}";
        edit-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; vim `f`";
        fuck = "commit --amend -m";
        graph = "log --all --decorate --graph";
        ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
        pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
        af = "!git add $(git ls-files -m -o --exclude-standard | fzf -m)";
        st = "status";
        hist = ''
          log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all
        '';
        llog = ''
          log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative
        '';
      };
    };
  };
}
