import imageio
import glob

images = []

for filename in glob.glob('*.jpg'):
    images.append(imageio.imread(filename))
imageio.mimsave('visual.gif', images)