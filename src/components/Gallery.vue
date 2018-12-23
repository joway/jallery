<template>
  <div :class="`gallery ${imageUrl !== null ? 'display' : 'hide'}`">
    <img :src="`${imageUrl}`" class="gallery-img">
    <div class="gallery-desc">
      <span>{{imageDesc}}</span>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator'
import { Image } from '@/types'

@Component
export default class Gallery extends Vue {
  @Prop() private imageUrl!: string | null
  @Prop() private imageDesc!: string | null
}
</script>

<style scoped>
.gallery {
  position: fixed;
  width: 100%;
  height: 100%;
  background-color: whitesmoke;
  margin: 0;
  padding: 0;
}
.gallery-img {
  position: absolute;
  border: solid 10px #000;
  box-shadow: 20px 20px 20px #ccc;
  margin: auto;
  max-height: 80%;
  max-width: 80%;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
}
.gallery-desc {
  position: absolute;
  bottom: 30px;
  width: 100%;
  text-align: center;
  font-size: large;
}
.hide {
  display: none;
}
</style>
