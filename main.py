
import gymnasium as gym
import pandas as pd
from stable_baselines3 import PPO
import sys
sys.stdout = open('file_out.txt', 'w')
env = gym.make("highway-fast-v0")

model = PPO("MlpPolicy", env, verbose=1)
model.learn(total_timesteps=20000)

vec_env = model.get_env()
obs = vec_env.reset()
obs_act = []
for i in range(1000):
    action, _states = model.predict(obs, deterministic=True)
    obs_act.append([obs, action])
    obs, reward, done, info = vec_env.step(action)
    vec_env.render()
    # VecEnv resets automatically
    # if done:
    #   obs = env.reset()

env.close()
oa = pd.DataFrame(obs_act)
oa.columns = ['obs', 'action']
oa.to_csv('obs_act.csv')
sys.stdout.close()