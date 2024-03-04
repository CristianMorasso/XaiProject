#!/usr/bin/env python3
import gymnasium as gym
import pandas as pd
from stable_baselines3 import PPO
import sys
sys.stdout = open('file_out.txt', 'w')

env = gym.make("highway-fast-v0")
config = {
    "observation": {
        "type": "Kinematics",
        "vehicles_count": 15,
        "features": ["presence", "x", "y", "vx", "vy"],
        "features_range": {
            "x": [-100, 100],
            "y": [-100, 100],
            "vx": [-20, 20],
            "vy": [-20, 20]
        },
        "absolute": False,
        "order": "sorted"
    }
}

env.configure(config)
obs, info = env.reset()
model = PPO("MlpPolicy", env, verbose=1)
model.learn(total_timesteps=10_000)
model.save("ppoHigh")

vec_env = model.get_env()
obs = vec_env.reset()
for i in range(1000):
    action, _states = model.predict(obs, deterministic=True)
    obs, reward, done, info = vec_env.step(action)
    #vec_env.render()
    # VecEnv resets automatically
    if done:
       obs = env.reset(seed=i)

env.close()
oa = pd.DataFrame(obs_act)
oa.columns = ['obs', 'action']
oa.to_csv('obs_act.csv')
sys.stdout.close()
