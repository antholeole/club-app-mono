import Particles from 'react-tsparticles'
import LandingParticlesStyles from './landing_particles.module.scss'

export const LandingParticles = (): JSX.Element => (
  <Particles
    className={LandingParticlesStyles.particles}
    options={{
      fpsLimit: 40,
      interactivity: {
        detectsOn: 'canvas',
        events: {
          onHover: {
            enable: true,
            mode: 'repulse',
          },
          resize: true,
        },
        modes: {
          repulse: {
            distance: 200,
            duration: 0.5,
          },
        },
      },
      particles: {
        color: {
          value: '#ff5e4d',
        },
        collisions: {
          enable: true,
        },
        move: {
          direction: 'none',
          enable: true,
          outMode: 'out',
          random: false,
          speed: {
            min: 0.3,
            max: 1.5,
          },
          straight: false,
        },
        rotate: {
          value: {
            min: 0,
            max: 360,
          },
        },
        number: {
          value: 10,
        },
        opacity: {
          value: {
            min: 0.3,
            max: 0.4,
          },
        },
        shape: {
          type: ['circle'],
          options: {
            circle: [
              {
                fill: false,
                particles: {
                  stroke: {
                    width: 2,
                  },
                },
              },
            ],
          },
        },
        size: {
          value: {
            min: 2,
            max: 4,
          },
        },
      },
    }}
  />
)
