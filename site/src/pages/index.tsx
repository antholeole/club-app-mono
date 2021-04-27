import React from 'react'
import { Splash } from '../components/landing/splash/splash'
import { Navbar } from '../components/global/navbar/navbar'

export default function Home() {
  return (
    <div style={{ minHeight: '1000vh' }}>
      <Navbar />
      <Splash />
      <main />
    </div>
  )
}
