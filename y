import pygame
import random

# Initialize Pygame
pygame.init()

# Screen dimensions
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
SCREEN = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption("2D Catch Game")

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
RED = (255, 0, 0)
BLUE = (0, 0, 255)
GREEN = (0, 255, 0)

# Player properties
player_width = 100
player_height = 20
player_x = (SCREEN_WIDTH - player_width) // 2
player_y = SCREEN_HEIGHT - player_height - 10
player_speed = 10
player_rect = pygame.Rect(player_x, player_y, player_width, player_height)

# Falling object properties
object_size = 20
object_speed = 5
falling_objects = []

# Game variables
score = 0
font = pygame.font.Font(None, 36)

# Game loop
running = True
clock = pygame.time.Clock()

while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Player movement
    keys = pygame.key.get_pressed()
    if keys[pygame.K_LEFT] and player_rect.left > 0:
        player_rect.x -= player_speed
    if keys[pygame.K_RIGHT] and player_rect.right < SCREEN_WIDTH:
        player_rect.x += player_speed

    # Generate falling objects
    if random.randint(0, 100) < 5:  # Adjust probability for more/fewer objects
        object_x = random.randint(0, SCREEN_WIDTH - object_size)
        object_y = 0
        falling_objects.append(pygame.Rect(object_x, object_y, object_size, object_size))

    # Update falling objects
    for obj in falling_objects[:]:  # Iterate over a slice to allow removal
        obj.y += object_speed
        if obj.y > SCREEN_HEIGHT:
            falling_objects.remove(obj)

    # Collision detection
    for obj in falling_objects[:]:
        if player_rect.colliderect(obj):
            falling_objects.remove(obj)
            score += 1

    # Drawing
    SCREEN.fill(BLACK)
    pygame.draw.rect(SCREEN, BLUE, player_rect)
    for obj in falling_objects:
        pygame.draw.rect(SCREEN, RED, obj)

    # Display score
    score_text = font.render(f"Score: {score}", True, WHITE)
    SCREEN.blit(score_text, (10, 10))

    pygame.display.flip()
    clock.tick(60)

pygame.quit()

