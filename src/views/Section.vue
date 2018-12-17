<template>
  <div class="row">
    <div class="col-xs">
      <Gallery
        :imageUrl="galleryImageUrl"
        :imageDesc="galleryImageDesc"
        @click.native="galleryImageUrl = null;galleryImageDesc=null;"
      ></Gallery>

      <div class="row page">
        <div class="col-xs">
          <div class="row">
            <div class="col-xs-12 col-md-9">
              <router-link to="/">
                <h1 class="site-name">Jallery</h1>
              </router-link>
            </div>
            <div class="col-xs-12 col-md-3">
              <div class="row end-xs">
                <div class="col-xs nav">
                  <a
                    class="nav-item"
                    href="https://blog.joway.io"
                    target="_blank"
                  >
                    Blog
                  </a>
                  <a
                    class="nav-item"
                    href="https://www.instagram.com/joway.w/"
                    target="_blank"
                  >
                    Instagram
                  </a>
                  <a
                    class="nav-item"
                    href="https://joway.io"
                    target="_blank"
                  >
                    @Joway
                  </a>
                </div>
              </div>
            </div>
          </div>
          <div
            class="row section"
            v-for="(section, index) in sections"
            :key="index"
          >
            <div class="col-xs">
              <div class="row end-xs">
                <div class="col-xs">
                  <h2 class="section-title">{{ section.title.replace(/=/g, ' ') }}</h2>
                </div>
              </div>

              <div class="row">
                <div
                  class="col-xs-12 col-sm-6 col-md-3"
                  v-for="(image, index) in section.images"
                  :key="index"
                  @click="clickImage(image)"
                >
                  <div class="row center-xs">
                    <Frame :image="image" />
                  </div>
                </div>
              </div>
            </div>
          </div>

          <footer class="row center-xs footer">
            <h5>Shoot with ❤ </h5>
          </footer>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator'
import axios from 'axios'
import Gallery from '@/components/Gallery.vue'
import Frame from '@/components/Frame.vue'
import { Section } from '@/types'

@Component({
  components: {
    Frame,
    Gallery,
  },
})
export default class Home extends Vue {
  sections: Section[] = []
  galleryImageUrl: string | null = null
  galleryImageDesc: string | null = null

  created() {
    axios.get('/photos/index.json').then(response => {
      this.sections = response.data
    })
  }

  clickImage(image) {
    this.galleryImageUrl = image.url
    this.galleryImageDesc = image.desc.replace(/=/g, ' ')
  }
}
</script>
<style scoped>
.site-name {
  font-family: 'Permanent Marker', Times, serif;
}
.page {
  margin: 0 50px;
}
.section {
}
.section-title {
  /* margin-left: 64px; */
}

.nav {
  margin: 30px 0;
}
.nav-item {
  margin: 0 12px;
}
.nav-item:hover {
  text-decoration: underline;
}
.footer {
  height: 100px;
}
</style>
