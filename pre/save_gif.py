import imageio
import glob

images = []

for filename in glob.glob('*.jpg'):
    images.append(imageio.imread(filename))
imageio.mimsave('visual.gif', images)
print('已保存为gif图片！')