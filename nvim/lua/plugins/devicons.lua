return {
  {
    "nvim-tree/nvim-web-devicons",

    lazy     = false,

    priority = 1100,

    config   = function()
      require("nvim-web-devicons").setup({
        override_by_filename = {
          ["Dockerfile"]           = { icon = "", color = "#458ee6", name = "Dockerfile" },
          ["docker-compose.yml"]   = { icon = "", color = "#458ee6", name = "DockerCompose" },
          ["docker-compose.yaml"]  = { icon = "", color = "#458ee6", name = "DockerCompose" },

          -- Ruby/Rails
          ["Gemfile"]              = { icon = "", color = "#701516", name = "Gemfile" },
          ["Gemfile.lock"]         = { icon = "", color = "#701516", name = "GemfileLock" },
          ["Rakefile"]             = { icon = "", color = "#701516", name = "Rakefile" },

          -- IaC / Cloud
          ["terraform.tf"]         = { icon = "󱁢", color = "#7b42bc", name = "Terraform" },
          ["terraform.tfvars"]     = { icon = "󱁢", color = "#7b42bc", name = "TerraformVars" },
          ["kustomization.yaml"]   = { icon = "󱁺", color = "#326ce5", name = "Kustomize" },

          -- VCS / CI
          [".gitignore"]           = { icon = "", color = "#f14e32", name = "GitIgnore" },
          [".gitattributes"]       = { icon = "", color = "#f14e32", name = "GitAttr" },
          [".gitlab-ci.yml"]       = { icon = "", color = "#e24329", name = "GitlabCI" },
          [".github/workflows"]    = { icon = "", color = "#24292e", name = "GithubActions" },

          -- Ruby / Rails
          [".rspec"]               = { icon = "", color = "#701516", name = "Rspec" },

          -- Node / JS tooling
          [".eslintrc"]            = { icon = "󰯷", color = "#4b32c3", name = "Eslintrc" },
          [".prettierrc"]          = { icon = "󰛨", color = "#f7b93e", name = "Prettierrc" },

          -- Infrastructure / Ops
          [".terraform.lock.hcl"]  = { icon = "󱁢", color = "#7b42bc", name = "TerraformLock" },
          ["Vagrantfile"]          = { icon = "", color = "#1563ff", name = "Vagrantfile" },

          -- Misc
          [".editorconfig"]        = { icon = "", color = "#ffffff", name = "EditorConfig" },
          [".env"]                 = { icon = "", color = "#6d8086", name = "Env" },
          [".env.local"]           = { icon = "", color = "#6d8086", name = "EnvLocal" },
          [".env.production"]      = { icon = "", color = "#6d8086", name = "EnvProd" },

          -- VCS / CI
          [".dockerignore"]        = { icon = "", color = "#458ee6", name = "DockerIgnore" },
          [".gitallowed"]          = { icon = "", color = "#f14e32", name = "GitAllowed" },

          -- Linter / Formatter / Tooling
          [".haml-lint.yml"]       = { icon = "", color = "#eaeaea", name = "HamlLint" },
          [".sass-lint.yml"]       = { icon = "", color = "#c6538c", name = "SassLint" },
          [".stylelintrc"]         = { icon = "", color = "#563d7c", name = "Stylelint" },
          [".prettierignore"]      = { icon = "󰛨", color = "#f7b93e", name = "PrettierIgnore" },
          [".rubocop.yml"]         = { icon = "", color = "#701516", name = "Rubocop" },
          [".rubocop_todo.yml"]    = { icon = "", color = "#701516", name = "RubocopTodo" },

          -- Language / Runtime バージョン指定
          [".node-version"]        = { icon = "", color = "#3c873a", name = "NodeVersion" },
          [".ruby-version"]        = { icon = "", color = "#701516", name = "RubyVersion" },

          -- Terraform / IaC
          [".terraformignore"]     = { icon = "󱁢", color = "#7b42bc", name = "TerraformIgnore" },

          -- Ruby/Rails その他
          ["Guardfile"]            = { icon = "", color = "#701516", name = "Guardfile" },
          ["config.ru"]            = { icon = "", color = "#701516", name = "ConfigRu" },

          -- Build / Package
          ["Makefile"]             = { icon = "", color = "#6d8086", name = "Makefile" },
          ["yarn.lock"]            = { icon = "", color = "#3489b2", name = "YarnLock" },

          -- Docker 関連
          ["docker-entrypoint.sh"] = { icon = "", color = "#458ee6", name = "DockerEntrypoint" },

          -- ESLint v9 config (flat)
          ["eslint.config.mjs"]    = { icon = "󰱘", color = "#4b32c3", name = "EslintConfig" },
        },

        override_by_extension = {
          -- Ruby / Rails
          haml     = { icon = "", color = "#eaeaea", name = "Haml" },
          erb      = { icon = "", color = "#eaeaea", name = "Erb" },
          slim     = { icon = "", color = "#eaeaea", name = "Slim" },
          rake     = { icon = "", color = "#701516", name = "Rake" },

          -- JavaScript / TypeScript
          js       = { icon = "", color = "#f1e05a", name = "Js" },
          jsx      = { icon = "", color = "#61dafb", name = "Jsx" },
          ts       = { icon = "", color = "#2b7489", name = "Ts" },
          tsx      = { icon = "", color = "#61dafb", name = "Tsx" },
          mjs      = { icon = "", color = "#f1e05a", name = "Mjs" },
          cjs      = { icon = "", color = "#cb3837", name = "Cjs" },

          -- Stylesheets
          css      = { icon = "", color = "#563d7c", name = "Css" },
          scss     = { icon = "", color = "#c6538c", name = "Scss" },
          sass     = { icon = "", color = "#c6538c", name = "Sass" },

          -- Markup / Docs
          md       = { icon = "", color = "#519aba", name = "Markdown" },
          markdown = { icon = "", color = "#519aba", name = "Markdown" },
          html     = { icon = "", color = "#e34c26", name = "Html" },

          -- Infrastructure
          tf       = { icon = "󱁢", color = "#7b42bc", name = "Terraform" },
          tfvars   = { icon = "󱁢", color = "#7b42bc", name = "TerraformVars" },
          yaml     = { icon = "󰈙", color = "#6d8086", name = "Yaml" },
          yml      = { icon = "󰈙", color = "#6d8086", name = "Yml" },
          sh       = { icon = "", color = "#89e051", name = "Shell" },

          -- Containers / Orchestration
          docker   = { icon = "", color = "#458ee6", name = "Docker" },
          k8s      = { icon = "󱃾", color = "#326ce5", name = "Kubernetes" },

          -- Misc Languages
          go       = { icon = "", color = "#00acd7", name = "Go" },
          py       = { icon = "", color = "#3572A5", name = "Python" },
          rs       = { icon = "", color = "#dea584", name = "Rust" },

        },

        default = true,
      })
    end,
  },
}
