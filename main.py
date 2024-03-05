#!/usr/bin/env python3
import gymnasium as gym
import numpy as np
import pandas as pd
from stable_baselines3 import PPO
import sys
sys.stdout = open('file_out.txt', 'w')

env = gym.make("highway-fast-v0")
config = {
    "observation": {
        "type": "Kinematics",
        "vehicles_count": 10,
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

env.unwrapped.configure(config)
obs, info = env.reset()
model = PPO("MlpPolicy", env, verbose=1)
vec_env = env
# model.learn(total_timesteps=10)
# model.save("ppoHigh")
# model = PPO.load("ppoHigh", env=env)
obs_act =  []
vec_env = model.get_env()
obs = vec_env.reset()
for i in range(2):
    obs = vec_env.reset()
    done = False
    while not done:
        action, _states = model.predict(obs, deterministic=True)
        obs_act.append([obs.flatten(), action.flatten()])
        obs, reward, done, info = vec_env.step(action)
        #vec_env.render()
        # VecEnv resets automatically
        
        # if done:
            
        #     obs = env.reset(seed=i)

env.close()

# oa = pd.DataFrame(obs_act)
# oa.columns = ['obs', 'action']
# oa.to_csv('obs_act_test.csv')
np.save("oa.npy",np.array(obs_act))
# print(oa["obs"][0])
sys.stdout.close()

