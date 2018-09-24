const fs = require('fs')

const PHOTOS_DIR = './public/photos'
const PHOTOS_INDEX_FILENAME = './public/photos/index.json'

function getFileExtension(filename) {
  return `.${filename.split('.').pop()}`
}

function gen() {
  const sections = []
  const sectionList = fs.readdirSync(PHOTOS_DIR)
  sectionList.forEach(dirName => {
    if (dirName === '.DS_Store' || dirName === 'index.json') {
      return
    }
    const dirFullName = PHOTOS_DIR + '/' + dirName
    const sectionTitle = dirFullName.split('-')[1]
    const images = []
    const photosList = fs.readdirSync(dirFullName)
    photosList.forEach(function(filename) {
      images.push({
        url: `/photos/${dirName}/${filename}`,
        desc: filename.replace(getFileExtension(filename), '').split('-')[1],
      })
    })

    sections.push({
      title: sectionTitle,
      images,
    })
  })

  fs.writeFileSync(PHOTOS_INDEX_FILENAME, JSON.stringify(sections), {
    encoding: 'utf8',
  })
}

gen()
