const fs = require('fs')

const PHOTOS_DIR = './public/photos'
const PHOTOS_INDEX_FILENAME = './public/photos/index.json'
const DOMAIN = process.env.DOMAIN || 'pho.joway.io'
const SCHEME = process.env.SCHEME || 'https'

function getFileExtension(filename) {
  return `.${filename.split('.').pop()}`
}

function gen() {
  const sections = []
  const sectionList = fs.readdirSync(PHOTOS_DIR).reverse()
  sectionList.forEach(dirName => {
    if (dirName === '.DS_Store' || dirName === 'index.json') {
      return
    }
    const dirFullName = PHOTOS_DIR + '/' + dirName
    const sectionTitle = dirFullName.split('-')[1]
    const images = []
    const photosList = fs.readdirSync(dirFullName)
    photosList.forEach(function(filename) {
      if (filename.includes('thumbnail')) {
        return
      }
      const pos = filename.lastIndexOf('.')
      const thumbnailFilename = `${filename.substr(0, pos)}.thumbnail${filename.substr(
        pos,
        filename.length,
      )}`
      images.push({
        // url: `${SCHEME}://${DOMAIN}/photos/${dirName}/${filename}`,
        url: `/photos/${dirName}/${filename}`,
        thumbnailUrl: `/photos/${dirName}/${thumbnailFilename}`,
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
