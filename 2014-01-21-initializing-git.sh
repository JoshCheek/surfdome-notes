# initalizing a new git repo
git init    # initialize the repo
git status  # files are untracked
git add .   # add all files to the staging area
git status  # files are in staging (to be committed)
git commit -m 'initial commit'
git status  # nothing to commit
git log     # I can see my commit

# push up to github
# go to https://github.com/new
git remote add origin <url-from-github>
git push -u origin master
