-include .env

# 'phony' means 'fake', .PHONY 声明了伪目标。通常用于定义一些命令。这样可以确保即使存在与这些 command 同名的文件，Make 也会执行这些命令。
.PHONY: all test test-zk clean deploy fund help install snapshot format anvil install deploy deploy-zk deploy-zk-sepolia deploy-sepolia verify

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
DEFAULT_ZKSYNC_LOCAL_KEY := 0x7726827caac94a7f9e1b160f7ea819f172f7b6f9d2a97f992c38edeab82d4110

# all 是一个目标，它依赖于其他目标 clean、remove、install、update 和 build。运行 make all 会依次执行这些目标。
all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install cyfrin/foundry-devops@0.2.2 --no-commit && forge install foundry-rs/forge-std@v1.8.2 --no-commit && forge install openzeppelin/openzeppelin-contracts@v5.0.2 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

test-zk :; foundryup-zksync && forge test --zksync && foundryup

snapshot :; forge snapshot

format :; forge fmt

# anvil 目标会运行 anvil 命令，使用指定的助记词生成本地 Ethereum 节点，启用步骤跟踪，并设置块时间为 1 秒。
anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1


# 有 @ 符号: 如果命令前有 @ 符号，Makefile 在执行该命令时不会显示命令本身，只会显示命令的输出结果
deploy:
	@forge create src/OurToken.sol:OurToken --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

deploy-sepolia:
	@forge script script/DeployOurToken.s.sol:DeployOurToken --rpc-url $(SEPOLIA_RPC_URL) --account $(ACCOUNT) --sender $(SENDER) --etherscan-api-key $(ETHERSCAN_API_KEY) --broadcast --verify

deploy-zk:
	@forge create src/OurToken.sol:OurToken --rpc-url http://127.0.0.1:8011 --private-key $(DEFAULT_ZKSYNC_LOCAL_KEY) --legacy --zksync

deploy-zk-sepolia:
	@forge create src/OurToken.sol:OurToken --rpc-url $(ZKSYNC_SEPOLIA_RPC_URL) --account $(ACCOUNT) --legacy --zksync

deploy-zk-bad:
	@forge create src/OurToken.sol:OurToken --rpc-url https://sepolia.era.zksync.dev --private-key $(PRIVATE_KEY) --legacy --zksync

verify:
	@forge verify-contract --chain-id 11155111 --num-of-optimizations 200 --watch --constructor-args 0x00000000000000000000000000000000000000000000d3c21bcecceda1000000 --etherscan-api-key $(ETHERSCAN_API_KEY) --compiler-version v0.8.19+commit.7dd6d404 0x089dc24123e0a27d44282a1ccc2fd815989e3300 src/OurToken.sol:OurToken