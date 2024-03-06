
import gymnasium as gym

from stable_baselines3 import PPO

env = gym.make("highway-fast-v0", render_mode="human")
print(env.observation_space, env.action_space)
model = PPO("MlpPolicy", env, verbose=1, device="cpu")
model.load("ppo20k")
# model.learn(total_timesteps=10_000)
# model= PPO.load("ppo20k", env=model.get_env(), print_system_info=True)
# vec_env = model.get_env()
# model = PPO.load("ppo20k", env=env, observation_space=env.observation_space, action_space=env.action_space, device="cpu")
# model = PPO.set_parameters("nets/policy.pth", env=env)
# model.load_dict("nets/policy.pth")
vec_env = model.get_env()
obs = vec_env.reset()
for i in range(20):
    action, _states = model.predict(obs, deterministic=True)
    obs, reward, done, info = vec_env.step(action)
    vec_env.render()
    # VecEnv resets automatically
    # if done:
    #   obs = env.reset()

env.close()